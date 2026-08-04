const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;

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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSecretValueInput, options: CallOptions) !GetSecretValueOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "secretsmanager", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetSecretValueInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("secretsmanager", "Secrets Manager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "secretsmanager.GetSecretValue");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSecretValueOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetSecretValueOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "DecryptionFailure")) {
        const parsed_error: ?errors.DecryptionFailure = aws.json.parseJsonObject(errors.DecryptionFailure, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .decryption_failure = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "EncryptionFailure")) {
        const parsed_error: ?errors.EncryptionFailure = aws.json.parseJsonObject(errors.EncryptionFailure, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .encryption_failure = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalServiceError")) {
        const parsed_error: ?errors.InternalServiceError = aws.json.parseJsonObject(errors.InternalServiceError, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_service_error = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        const parsed_error: ?errors.InvalidNextTokenException = aws.json.parseJsonObject(errors.InvalidNextTokenException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        const parsed_error: ?errors.InvalidParameterException = aws.json.parseJsonObject(errors.InvalidParameterException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        const parsed_error: ?errors.InvalidRequestException = aws.json.parseJsonObject(errors.InvalidRequestException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_request_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        const parsed_error: ?errors.LimitExceededException = aws.json.parseJsonObject(errors.LimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MalformedPolicyDocumentException")) {
        const parsed_error: ?errors.MalformedPolicyDocumentException = aws.json.parseJsonObject(errors.MalformedPolicyDocumentException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .malformed_policy_document_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PreconditionNotMetException")) {
        const parsed_error: ?errors.PreconditionNotMetException = aws.json.parseJsonObject(errors.PreconditionNotMetException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .precondition_not_met_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PublicPolicyException")) {
        const parsed_error: ?errors.PublicPolicyException = aws.json.parseJsonObject(errors.PublicPolicyException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .public_policy_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceExistsException")) {
        const parsed_error: ?errors.ResourceExistsException = aws.json.parseJsonObject(errors.ResourceExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        const parsed_error: ?errors.ResourceNotFoundException = aws.json.parseJsonObject(errors.ResourceNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
