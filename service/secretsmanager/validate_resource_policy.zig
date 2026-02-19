const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ValidationErrorsEntry = @import("validation_errors_entry.zig").ValidationErrorsEntry;

pub const ValidateResourcePolicyInput = struct {
    /// A JSON-formatted string that contains an Amazon Web Services resource-based
    /// policy. The policy in
    /// the string identifies who can access or manage this secret and its versions.
    /// For example
    /// policies, see [Permissions
    /// policy
    /// examples](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access_examples.html).
    resource_policy: []const u8,

    /// The ARN or name of the secret with the resource-based policy you want to
    /// validate.
    secret_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .resource_policy = "ResourcePolicy",
        .secret_id = "SecretId",
    };
};

pub const ValidateResourcePolicyOutput = struct {
    /// True if your policy passes validation, otherwise false.
    policy_validation_passed: ?bool = null,

    /// Validation errors if your policy didn't pass validation.
    validation_errors: ?[]const ValidationErrorsEntry = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ValidateResourcePolicyOutput) void {
        self._arena.deinit();
    }

    pub const json_field_names = .{
        .policy_validation_passed = "PolicyValidationPassed",
        .validation_errors = "ValidationErrors",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ValidateResourcePolicyInput, options: Options) !ValidateResourcePolicyOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ValidateResourcePolicyInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "secretsmanager.ValidateResourcePolicy");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ValidateResourcePolicyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ValidateResourcePolicyOutput, body, alloc);
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
