const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

pub const GetRandomPasswordInput = struct {
    /// A string of the characters that you don't want in the password.
    exclude_characters: ?[]const u8 = null,

    /// Specifies whether to exclude lowercase letters from the password. If you
    /// don't include
    /// this switch, the password can contain lowercase letters.
    exclude_lowercase: ?bool = null,

    /// Specifies whether to exclude numbers from the password. If you don't include
    /// this
    /// switch, the password can contain numbers.
    exclude_numbers: ?bool = null,

    /// Specifies whether to exclude the following punctuation characters from the
    /// password:
    /// `! " # $ % & ' ( ) * + , - . / : ; ? @ [ \ ] ^ _ ` { | }
    /// ~`. If you don't include this switch, the password can contain
    /// punctuation.
    exclude_punctuation: ?bool = null,

    /// Specifies whether to exclude uppercase letters from the password. If you
    /// don't include
    /// this switch, the password can contain uppercase letters.
    exclude_uppercase: ?bool = null,

    /// Specifies whether to include the space character. If you include this
    /// switch, the
    /// password can contain space characters.
    include_space: ?bool = null,

    /// The length of the password. If you don't include this parameter, the default
    /// length is
    /// 32 characters.
    password_length: ?i64 = null,

    /// Specifies whether to include at least one upper and lowercase letter, one
    /// number, and
    /// one punctuation. If you don't include this switch, the password contains at
    /// least one of
    /// every character type.
    require_each_included_type: ?bool = null,

    pub const json_field_names = .{
        .exclude_characters = "ExcludeCharacters",
        .exclude_lowercase = "ExcludeLowercase",
        .exclude_numbers = "ExcludeNumbers",
        .exclude_punctuation = "ExcludePunctuation",
        .exclude_uppercase = "ExcludeUppercase",
        .include_space = "IncludeSpace",
        .password_length = "PasswordLength",
        .require_each_included_type = "RequireEachIncludedType",
    };
};

pub const GetRandomPasswordOutput = struct {
    /// A string with the password.
    random_password: ?[]const u8 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *GetRandomPasswordOutput) void {
        self._arena.deinit();
    }

    pub const json_field_names = .{
        .random_password = "RandomPassword",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: GetRandomPasswordInput, options: Options) !GetRandomPasswordOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .unknown = .{ .http_status = @intCast(response.status) } };
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetRandomPasswordInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "secretsmanager.GetRandomPassword");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetRandomPasswordOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetRandomPasswordOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    const owned_message = try alloc.dupe(u8, error_message);
    errdefer alloc.free(owned_message);
    const owned_request_id = try alloc.dupe(u8, "");
    errdefer alloc.free(owned_request_id);

    if (std.mem.eql(u8, error_code, "DecryptionFailure")) {
        return .{ .decryption_failure = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "EncryptionFailure")) {
        return .{ .encryption_failure = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceError")) {
        return .{ .internal_service_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .invalid_next_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "MalformedPolicyDocumentException")) {
        return .{ .malformed_policy_document_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "PreconditionNotMetException")) {
        return .{ .precondition_not_met_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "PublicPolicyException")) {
        return .{ .public_policy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceExistsException")) {
        return .{ .resource_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }

    const owned_code = try alloc.dupe(u8, error_code);
    return .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
        ._allocator = alloc,
    } };
}
