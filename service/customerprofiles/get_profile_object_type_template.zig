const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ObjectTypeField = @import("object_type_field.zig").ObjectTypeField;
const ObjectTypeKey = @import("object_type_key.zig").ObjectTypeKey;

pub const GetProfileObjectTypeTemplateInput = struct {
    /// A unique identifier for the object template.
    template_id: []const u8,

    pub const json_field_names = .{
        .template_id = "TemplateId",
    };
};

pub const GetProfileObjectTypeTemplateOutput = struct {
    /// Indicates whether a profile should be created when data is received if one
    /// doesn’t exist
    /// for an object of this type. The default is `FALSE`. If the
    /// AllowProfileCreation
    /// flag is set to `FALSE`, then the service tries to fetch a standard profile
    /// and
    /// associate this object with the profile. If it is set to `TRUE`, and if no
    /// match
    /// is found, then the service creates a new standard profile.
    allow_profile_creation: ?bool = null,

    /// A map of the name and ObjectType field.
    fields: ?[]const aws.map.MapEntry(ObjectTypeField) = null,

    /// A list of unique keys that can be used to map data to the profile.
    keys: ?[]const aws.map.MapEntry([]const ObjectTypeKey) = null,

    /// The format of your `sourceLastUpdatedTimestamp` that was previously set
    /// up.
    source_last_updated_timestamp_format: ?[]const u8 = null,

    /// The name of the source of the object template.
    source_name: ?[]const u8 = null,

    /// The source of the object template.
    source_object: ?[]const u8 = null,

    /// A unique identifier for the object template.
    template_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .allow_profile_creation = "AllowProfileCreation",
        .fields = "Fields",
        .keys = "Keys",
        .source_last_updated_timestamp_format = "SourceLastUpdatedTimestampFormat",
        .source_name = "SourceName",
        .source_object = "SourceObject",
        .template_id = "TemplateId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetProfileObjectTypeTemplateInput, options: Options) !GetProfileObjectTypeTemplateOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetProfileObjectTypeTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("customerprofiles", "Customer Profiles", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/templates/");
    try path_buf.appendSlice(allocator, input.template_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetProfileObjectTypeTemplateOutput {
    var result: GetProfileObjectTypeTemplateOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetProfileObjectTypeTemplateOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
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
