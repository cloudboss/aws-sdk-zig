const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

/// Modifies the staging labels attached to a version of a secret. Secrets
/// Manager uses staging
/// labels to track a version as it progresses through the secret rotation
/// process. Each
/// staging label can be attached to only one version at a time. To add a
/// staging label to a
/// version when it is already attached to another version, Secrets Manager
/// first removes it from the
/// other version first and then attaches it to this one. For more information
/// about
/// versions and staging labels, see [Concepts:
/// Version](https://docs.aws.amazon.com/secretsmanager/latest/userguide/getting-started.html#term_version).
///
/// The staging labels that you specify in the `VersionStage` parameter are
/// added to the existing list of staging labels for the version.
///
/// You can move the `AWSCURRENT` staging label to this version by including it
/// in this call.
///
/// **Note:**
///
/// Whenever you move `AWSCURRENT`, Secrets Manager automatically moves the
/// label
/// `AWSPREVIOUS` to the version that `AWSCURRENT` was removed
/// from.
///
/// If this action results in the last label being removed from a version, then
/// the
/// version is considered to be 'deprecated' and can be deleted by Secrets
/// Manager.
///
/// Secrets Manager generates a CloudTrail log entry when you call this action.
/// Do not include sensitive information in request parameters because it might
/// be logged. For more information, see [Logging Secrets Manager events with
/// CloudTrail](https://docs.aws.amazon.com/secretsmanager/latest/userguide/retrieve-ct-entries.html).
///
/// **Required permissions:
/// **
/// `secretsmanager:UpdateSecretVersionStage`. For more information, see [
/// IAM policy actions for Secrets
/// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/reference_iam-permissions.html#reference_iam-permissions_actions) and [Authentication
/// and access control in Secrets
/// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access.html).
pub const UpdateSecretVersionStageInput = struct {
    /// The ID of the version to add the staging label to. To remove a label from a
    /// version,
    /// then do not specify this parameter.
    ///
    /// If the staging label is already attached to a different version of the
    /// secret, then
    /// you must also specify the `RemoveFromVersionId` parameter.
    move_to_version_id: ?[]const u8 = null,

    /// The ID of the version that the staging label is to be removed from. If the
    /// staging
    /// label you are trying to attach to one version is already attached to a
    /// different
    /// version, then you must include this parameter and specify the version that
    /// the label is
    /// to be removed from. If the label is attached and you either do not specify
    /// this
    /// parameter, or the version ID does not match, then the operation fails.
    remove_from_version_id: ?[]const u8 = null,

    /// The ARN or the name of the secret with the version and staging labelsto
    /// modify.
    ///
    /// For an ARN, we recommend that you specify a complete ARN rather
    /// than a partial ARN. See [Finding a secret from a partial
    /// ARN](https://docs.aws.amazon.com/secretsmanager/latest/userguide/troubleshoot.html#ARN_secretnamehyphen).
    secret_id: []const u8,

    /// The staging label to add to this version.
    version_stage: []const u8,

    pub const json_field_names = .{
        .move_to_version_id = "MoveToVersionId",
        .remove_from_version_id = "RemoveFromVersionId",
        .secret_id = "SecretId",
        .version_stage = "VersionStage",
    };
};

pub const UpdateSecretVersionStageOutput = struct {
    /// The ARN of the secret that was updated.
    arn: ?[]const u8 = null,

    /// The name of the secret that was updated.
    name: ?[]const u8 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *UpdateSecretVersionStageOutput) void {
        self._arena.deinit();
    }

    pub const json_field_names = .{
        .arn = "ARN",
        .name = "Name",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: UpdateSecretVersionStageInput, options: Options) !UpdateSecretVersionStageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "secretsmanager");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateSecretVersionStageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("secretsmanager", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "secretsmanager.UpdateSecretVersionStage");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateSecretVersionStageOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateSecretVersionStageOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";

    if (std.mem.eql(u8, error_code, "DecryptionFailure")) {
        return .{ .decryption_failure = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "EncryptionFailure")) {
        return .{ .encryption_failure = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceError")) {
        return .{ .internal_service_error = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .invalid_next_token_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .invalid_parameter_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .invalid_request_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "MalformedPolicyDocumentException")) {
        return .{ .malformed_policy_document_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "PreconditionNotMetException")) {
        return .{ .precondition_not_met_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "PublicPolicyException")) {
        return .{ .public_policy_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceExistsException")) {
        return .{ .resource_exists_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .resource_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }

    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = "",
        .http_status = status,
    } };
}
