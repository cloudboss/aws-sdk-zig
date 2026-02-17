const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

pub const GetSecretValueInput = struct {
    /// The ARN or name of the secret to retrieve. To retrieve a secret from another
    /// account,
    /// you must use an ARN.
    ///
    /// For an ARN, we recommend that you specify a complete ARN rather
    /// than a partial ARN. See [Finding a secret from a partial
    /// ARN](https://docs.aws.amazon.com/secretsmanager/latest/userguide/troubleshoot.html#ARN_secretnamehyphen).
    secret_id: []const u8,

    /// The unique identifier of the version of the secret to retrieve. If you
    /// include both
    /// this parameter and `VersionStage`, the two parameters must refer to the same
    /// secret version. If you don't specify either a `VersionStage` or
    /// `VersionId`, then Secrets Manager returns the `AWSCURRENT`
    /// version.
    ///
    /// This value is typically a
    /// [UUID-type](https://wikipedia.org/wiki/Universally_unique_identifier)
    /// value with 32 hexadecimal digits.
    version_id: ?[]const u8 = null,

    /// The staging label of the version of the secret to retrieve.
    ///
    /// Secrets Manager uses staging labels to keep track of different versions
    /// during the rotation
    /// process. If you include both this parameter and `VersionId`, the two
    /// parameters must refer to the same secret version. If you don't specify
    /// either a
    /// `VersionStage` or `VersionId`, Secrets Manager returns the
    /// `AWSCURRENT` version.
    version_stage: ?[]const u8 = null,

    pub const json_field_names = .{
        .secret_id = "SecretId",
        .version_id = "VersionId",
        .version_stage = "VersionStage",
    };
};

pub const GetSecretValueOutput = struct {
    /// The ARN of the secret.
    arn: ?[]const u8 = null,

    /// The date and time that this version of the secret was created. If you don't
    /// specify
    /// which version in `VersionId` or `VersionStage`, then Secrets Manager uses
    /// the `AWSCURRENT` version.
    created_date: ?i64 = null,

    /// The friendly name of the secret.
    name: ?[]const u8 = null,

    /// The decrypted secret value, if the secret value was originally provided as
    /// binary data
    /// in the form of a byte array. When you retrieve a `SecretBinary` using the
    /// HTTP API, the Python SDK, or the Amazon Web Services CLI, the value is
    /// Base64-encoded. Otherwise, it
    /// is not encoded.
    ///
    /// If the secret was created by using the Secrets Manager console, or if the
    /// secret value was
    /// originally provided as a string, then this field is omitted. The secret
    /// value appears in
    /// `SecretString` instead.
    ///
    /// Sensitive: This field contains sensitive information, so the service does
    /// not include it in CloudTrail log entries. If you create your own log
    /// entries, you must also avoid logging the information in this field.
    secret_binary: ?[]const u8 = null,

    /// The decrypted secret value, if the secret value was originally provided as a
    /// string or
    /// through the Secrets Manager console.
    ///
    /// If this secret was created by using the console, then Secrets Manager stores
    /// the information as
    /// a JSON structure of key/value pairs.
    ///
    /// Sensitive: This field contains sensitive information, so the service does
    /// not include it in CloudTrail log entries. If you create your own log
    /// entries, you must also avoid logging the information in this field.
    secret_string: ?[]const u8 = null,

    /// The unique identifier of this version of the secret.
    version_id: ?[]const u8 = null,

    /// A list of all of the staging labels currently attached to this version of
    /// the
    /// secret.
    version_stages: ?[]const []const u8 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *GetSecretValueOutput) void {
        self._arena.deinit();
    }

    pub const json_field_names = .{
        .arn = "ARN",
        .created_date = "CreatedDate",
        .name = "Name",
        .secret_binary = "SecretBinary",
        .secret_string = "SecretString",
        .version_id = "VersionId",
        .version_stages = "VersionStages",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: GetSecretValueInput, options: Options) !GetSecretValueOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: GetSecretValueInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "secretsmanager.GetSecretValue");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetSecretValueOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetSecretValueOutput, body, alloc);
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
