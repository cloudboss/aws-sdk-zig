const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ExternalSecretRotationMetadataItem = @import("external_secret_rotation_metadata_item.zig").ExternalSecretRotationMetadataItem;
const RotationRulesType = @import("rotation_rules_type.zig").RotationRulesType;

pub const RotateSecretInput = struct {
    /// A unique identifier for the new version of the secret. You only need to
    /// specify this
    /// value if you implement your own retry logic and you want to ensure that
    /// Secrets Manager doesn't
    /// attempt to create a secret version twice.
    ///
    /// If you use the Amazon Web Services CLI or one of the Amazon Web Services
    /// SDKs to call this operation, then you can leave this parameter empty. The
    /// CLI or SDK generates a random UUID for you and includes it as the value for
    /// this parameter in the request.
    ///
    /// If you generate a raw HTTP request to the Secrets Manager service endpoint,
    /// then you must generate a `ClientRequestToken` and include it in the request.
    ///
    /// This value helps ensure idempotency. Secrets Manager uses this value to
    /// prevent the accidental creation of duplicate versions if there are failures
    /// and retries during a rotation. We recommend that you generate a
    /// [UUID-type](https://wikipedia.org/wiki/Universally_unique_identifier) value
    /// to ensure uniqueness of your versions within the specified secret.
    client_request_token: ?[]const u8 = null,

    /// The metadata needed to successfully rotate a managed external secret. A list
    /// of key
    /// value pairs in JSON format specified by the partner. For more information
    /// about the
    /// required information, see [Using Secrets Manager managed external
    /// secrets](https://docs.aws.amazon.com/secretsmanager/latest/userguide/managed-external-secrets.html)
    external_secret_rotation_metadata: ?[]const ExternalSecretRotationMetadataItem = null,

    /// The Amazon Resource Name (ARN) of the role that allows Secrets Manager to
    /// rotate a secret held
    /// by a third-party partner. For more information, see [Security and
    /// permissions](https://docs.aws.amazon.com/secretsmanager/latest/userguide/mes-security.html).
    external_secret_rotation_role_arn: ?[]const u8 = null,

    /// Specifies whether to rotate the secret immediately or wait until the next
    /// scheduled
    /// rotation window. The rotation schedule is defined in
    /// RotateSecretRequest$RotationRules.
    ///
    /// The default for `RotateImmediately` is `true`. If you don't
    /// specify this value, Secrets Manager rotates the secret immediately.
    ///
    /// If you set `RotateImmediately` to `false`, Secrets Manager tests
    /// the rotation configuration by running the [
    /// `testSecret`
    /// step](https://docs.aws.amazon.com/secretsmanager/latest/userguide/rotate-secrets_how.html) of the Lambda rotation function. This test
    /// creates an `AWSPENDING` version of the secret and then removes it.
    ///
    /// When changing an existing rotation schedule and setting `RotateImmediately`
    /// to `false`:
    ///
    /// * If using `AutomaticallyAfterDays` or a
    /// `ScheduleExpression` with `rate()`, the previously
    /// scheduled rotation might still occur.
    ///
    /// * To prevent unintended rotations, use a `ScheduleExpression` with
    /// `cron()` for granular control over rotation windows.
    ///
    /// Rotation is an asynchronous process. For more information, see [How rotation
    /// works](https://docs.aws.amazon.com/secretsmanager/latest/userguide/rotate-secrets_how.html).
    rotate_immediately: ?bool = null,

    /// For secrets that use a Lambda rotation function to rotate, the ARN of the
    /// Lambda
    /// rotation function.
    ///
    /// For secrets that use *managed rotation*, omit this field. For more
    /// information, see [Managed
    /// rotation](https://docs.aws.amazon.com/secretsmanager/latest/userguide/rotate-secrets_managed.html) in the *Secrets Manager User Guide*.
    rotation_lambda_arn: ?[]const u8 = null,

    /// A structure that defines the rotation configuration for this secret.
    ///
    /// When changing an existing rotation schedule and setting
    /// `RotateImmediately` to `false`:
    ///
    /// * If using `AutomaticallyAfterDays` or a
    /// `ScheduleExpression` with `rate()`, the previously
    /// scheduled rotation might still occur.
    ///
    /// * To prevent unintended rotations, use a `ScheduleExpression`
    /// with `cron()` for granular control over rotation windows.
    rotation_rules: ?RotationRulesType = null,

    /// The ARN or name of the secret to rotate.
    ///
    /// For an ARN, we recommend that you specify a complete ARN rather
    /// than a partial ARN. See [Finding a secret from a partial
    /// ARN](https://docs.aws.amazon.com/secretsmanager/latest/userguide/troubleshoot.html#ARN_secretnamehyphen).
    secret_id: []const u8,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .external_secret_rotation_metadata = "ExternalSecretRotationMetadata",
        .external_secret_rotation_role_arn = "ExternalSecretRotationRoleArn",
        .rotate_immediately = "RotateImmediately",
        .rotation_lambda_arn = "RotationLambdaARN",
        .rotation_rules = "RotationRules",
        .secret_id = "SecretId",
    };
};

pub const RotateSecretOutput = struct {
    /// The ARN of the secret.
    arn: ?[]const u8 = null,

    /// The name of the secret.
    name: ?[]const u8 = null,

    /// The ID of the new version of the secret.
    version_id: ?[]const u8 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *RotateSecretOutput) void {
        self._arena.deinit();
    }

    pub const json_field_names = .{
        .arn = "ARN",
        .name = "Name",
        .version_id = "VersionId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: RotateSecretInput, options: Options) !RotateSecretOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: RotateSecretInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("secretsmanager", "Secrets Manager", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "secretsmanager.RotateSecret");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !RotateSecretOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RotateSecretOutput, body, alloc);
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
