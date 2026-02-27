const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ObjectTypeField = @import("object_type_field.zig").ObjectTypeField;
const ObjectTypeKey = @import("object_type_key.zig").ObjectTypeKey;

pub const GetProfileObjectTypeInput = struct {
    /// The unique name of the domain.
    domain_name: []const u8,

    /// The name of the profile object type.
    object_type_name: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .object_type_name = "ObjectTypeName",
    };
};

pub const GetProfileObjectTypeOutput = struct {
    /// Indicates whether a profile should be created when data is received if one
    /// doesn’t exist
    /// for an object of this type. The default is `FALSE`. If the
    /// AllowProfileCreation
    /// flag is set to `FALSE`, then the service tries to fetch a standard profile
    /// and
    /// associate this object with the profile. If it is set to `TRUE`, and if no
    /// match
    /// is found, then the service creates a new standard profile.
    allow_profile_creation: bool = false,

    /// The timestamp of when the domain was created.
    created_at: ?i64 = null,

    /// The description of the profile object type.
    description: []const u8,

    /// The customer-provided key to encrypt the profile object that will be created
    /// in this
    /// profile object type.
    encryption_key: ?[]const u8 = null,

    /// The number of days until the data in the object expires.
    expiration_days: ?i32 = null,

    /// A map of the name and ObjectType field.
    fields: ?[]const aws.map.MapEntry(ObjectTypeField) = null,

    /// A list of unique keys that can be used to map data to the profile.
    keys: ?[]const aws.map.MapEntry([]const ObjectTypeKey) = null,

    /// The timestamp of when the domain was most recently edited.
    last_updated_at: ?i64 = null,

    /// The amount of provisioned profile object max count available.
    max_available_profile_object_count: ?i32 = null,

    /// The amount of profile object max count assigned to the object type.
    max_profile_object_count: ?i32 = null,

    /// The name of the profile object type.
    object_type_name: []const u8,

    /// The format of your `sourceLastUpdatedTimestamp` that was previously set
    /// up.
    source_last_updated_timestamp_format: ?[]const u8 = null,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// A unique identifier for the object template.
    template_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .allow_profile_creation = "AllowProfileCreation",
        .created_at = "CreatedAt",
        .description = "Description",
        .encryption_key = "EncryptionKey",
        .expiration_days = "ExpirationDays",
        .fields = "Fields",
        .keys = "Keys",
        .last_updated_at = "LastUpdatedAt",
        .max_available_profile_object_count = "MaxAvailableProfileObjectCount",
        .max_profile_object_count = "MaxProfileObjectCount",
        .object_type_name = "ObjectTypeName",
        .source_last_updated_timestamp_format = "SourceLastUpdatedTimestampFormat",
        .tags = "Tags",
        .template_id = "TemplateId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetProfileObjectTypeInput, options: Options) !GetProfileObjectTypeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "customerprofiles");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetProfileObjectTypeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("customerprofiles", "Customer Profiles", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/domains/");
    try path_buf.appendSlice(alloc, input.domain_name);
    try path_buf.appendSlice(alloc, "/object-types/");
    try path_buf.appendSlice(alloc, input.object_type_name);
    const path = try path_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetProfileObjectTypeOutput {
    var result: GetProfileObjectTypeOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetProfileObjectTypeOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
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
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
