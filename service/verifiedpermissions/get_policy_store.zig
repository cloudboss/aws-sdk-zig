const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CedarVersion = @import("cedar_version.zig").CedarVersion;
const DeletionProtection = @import("deletion_protection.zig").DeletionProtection;
const EncryptionState = @import("encryption_state.zig").EncryptionState;
const ValidationSettings = @import("validation_settings.zig").ValidationSettings;

pub const GetPolicyStoreInput = struct {
    /// Specifies the ID of the policy store that you want information about.
    policy_store_id: []const u8,

    /// Specifies whether to return the tags that are attached to the policy store.
    /// If this parameter is included in the API call, the tags are returned,
    /// otherwise they are not returned.
    ///
    /// If this parameter is included in the API call but there are no tags attached
    /// to the policy store, the `tags` response parameter is omitted from the
    /// response.
    tags: ?bool = null,

    pub const json_field_names = .{
        .policy_store_id = "policyStoreId",
        .tags = "tags",
    };
};

pub const GetPolicyStoreOutput = struct {
    /// The Amazon Resource Name (ARN) of the policy store.
    arn: []const u8,

    /// The version of the Cedar language used with policies, policy templates, and
    /// schemas in this policy store. For more information, see [Amazon Verified
    /// Permissions upgrade to Cedar v4
    /// FAQ](https://docs.aws.amazon.com/verifiedpermissions/latest/userguide/cedar4-faq.html).
    cedar_version: ?CedarVersion = null,

    /// The date and time that the policy store was originally created.
    created_date: i64,

    /// Specifies whether the policy store can be deleted. If enabled, the policy
    /// store can't be deleted.
    ///
    /// The default state is `DISABLED`.
    deletion_protection: ?DeletionProtection = null,

    /// Descriptive text that you can provide to help with identification of the
    /// current policy store.
    description: ?[]const u8 = null,

    /// A structure that contains the encryption configuration for the policy store.
    encryption_state: ?EncryptionState = null,

    /// The date and time that the policy store was last updated.
    last_updated_date: i64,

    /// The ID of the policy store;
    policy_store_id: []const u8,

    /// The list of tags associated with the policy store.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The current validation settings for the policy store.
    validation_settings: ?ValidationSettings = null,

    pub const json_field_names = .{
        .arn = "arn",
        .cedar_version = "cedarVersion",
        .created_date = "createdDate",
        .deletion_protection = "deletionProtection",
        .description = "description",
        .encryption_state = "encryptionState",
        .last_updated_date = "lastUpdatedDate",
        .policy_store_id = "policyStoreId",
        .tags = "tags",
        .validation_settings = "validationSettings",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPolicyStoreInput, options: Options) !GetPolicyStoreOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "verifiedpermissions");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetPolicyStoreInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("verifiedpermissions", "VerifiedPermissions", alloc);

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
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "VerifiedPermissions.GetPolicyStore");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetPolicyStoreOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetPolicyStoreOutput, body, alloc);
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
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidStateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
