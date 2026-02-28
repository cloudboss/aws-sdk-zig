const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const LayoutType = @import("layout_type.zig").LayoutType;

pub const CreateDomainLayoutInput = struct {
    /// The description of the layout
    description: []const u8,

    /// The display name of the layout
    display_name: []const u8,

    /// The unique name of the domain.
    domain_name: []const u8,

    /// If set to true for a layout, this layout will be used by default to view
    /// data. If set to
    /// false, then the layout will not be used by default, but it can be used to
    /// view data by
    /// explicitly selecting it in the console.
    is_default: ?bool = null,

    /// A customizable layout that can be used to view data under a Customer
    /// Profiles domain.
    layout: []const u8,

    /// The unique name of the layout.
    layout_definition_name: []const u8,

    /// The type of layout that can be used to view data under a Customer Profiles
    /// domain.
    layout_type: LayoutType,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .description = "Description",
        .display_name = "DisplayName",
        .domain_name = "DomainName",
        .is_default = "IsDefault",
        .layout = "Layout",
        .layout_definition_name = "LayoutDefinitionName",
        .layout_type = "LayoutType",
        .tags = "Tags",
    };
};

pub const CreateDomainLayoutOutput = struct {
    /// The timestamp of when the layout was created.
    created_at: i64,

    /// The description of the layout
    description: []const u8,

    /// The display name of the layout
    display_name: []const u8,

    /// If set to true for a layout, this layout will be used by default to view
    /// data. If set to
    /// false, then the layout will not be used by default, but it can be used to
    /// view data by
    /// explicitly selecting it in the console.
    is_default: ?bool = null,

    /// The timestamp of when the layout was most recently updated.
    last_updated_at: ?i64 = null,

    /// A customizable layout that can be used to view data under Customer Profiles
    /// domain.
    layout: []const u8,

    /// The unique name of the layout.
    layout_definition_name: []const u8,

    /// The type of layout that can be used to view data under customer profiles
    /// domain.
    layout_type: LayoutType,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The version used to create layout.
    version: []const u8,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .description = "Description",
        .display_name = "DisplayName",
        .is_default = "IsDefault",
        .last_updated_at = "LastUpdatedAt",
        .layout = "Layout",
        .layout_definition_name = "LayoutDefinitionName",
        .layout_type = "LayoutType",
        .tags = "Tags",
        .version = "Version",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDomainLayoutInput, options: Options) !CreateDomainLayoutOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateDomainLayoutInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("customerprofiles", "Customer Profiles", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/domains/");
    try path_buf.appendSlice(alloc, input.domain_name);
    try path_buf.appendSlice(alloc, "/layouts/");
    try path_buf.appendSlice(alloc, input.layout_definition_name);
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"Description\":");
    try aws.json.writeValue(@TypeOf(input.description), input.description, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"DisplayName\":");
    try aws.json.writeValue(@TypeOf(input.display_name), input.display_name, alloc, &body_buf);
    has_prev = true;
    if (input.is_default) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"IsDefault\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"Layout\":");
    try aws.json.writeValue(@TypeOf(input.layout), input.layout, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"LayoutType\":");
    try aws.json.writeValue(@TypeOf(input.layout_type), input.layout_type, alloc, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateDomainLayoutOutput {
    var result: CreateDomainLayoutOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateDomainLayoutOutput, body, alloc);
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
