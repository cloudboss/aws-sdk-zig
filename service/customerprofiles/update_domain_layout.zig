const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LayoutType = @import("layout_type.zig").LayoutType;

pub const UpdateDomainLayoutInput = struct {
    /// The description of the layout
    description: ?[]const u8 = null,

    /// The display name of the layout
    display_name: ?[]const u8 = null,

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
    layout: ?[]const u8 = null,

    /// The unique name of the layout.
    layout_definition_name: []const u8,

    /// The type of layout that can be used to view data under a Customer Profiles
    /// domain.
    layout_type: ?LayoutType = null,

    pub const json_field_names = .{
        .description = "Description",
        .display_name = "DisplayName",
        .domain_name = "DomainName",
        .is_default = "IsDefault",
        .layout = "Layout",
        .layout_definition_name = "LayoutDefinitionName",
        .layout_type = "LayoutType",
    };
};

pub const UpdateDomainLayoutOutput = struct {
    /// The timestamp of when the layout was created.
    created_at: ?i64 = null,

    /// The description of the layout
    description: ?[]const u8 = null,

    /// The display name of the layout
    display_name: ?[]const u8 = null,

    /// If set to true for a layout, this layout will be used by default to view
    /// data. If set to
    /// false, then the layout will not be used by default, but it can be used to
    /// view data by
    /// explicitly selecting it in the console.
    is_default: ?bool = null,

    /// The timestamp of when the layout was most recently updated.
    last_updated_at: ?i64 = null,

    /// A customizable layout that can be used to view data under a Customer
    /// Profiles domain.
    layout: ?[]const u8 = null,

    /// The unique name of the layout.
    layout_definition_name: ?[]const u8 = null,

    /// The type of layout that can be used to view data under a Customer Profiles
    /// domain.
    layout_type: ?LayoutType = null,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The version used to create layout.
    version: ?[]const u8 = null,

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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDomainLayoutInput, options: CallOptions) !UpdateDomainLayoutOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "profile", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDomainLayoutInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/layouts/");
    try path_buf.appendSlice(allocator, input.layout_definition_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.display_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DisplayName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.is_default) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IsDefault\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.layout) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Layout\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.layout_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LayoutType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDomainLayoutOutput {
    const result: UpdateDomainLayoutOutput = try aws.json.parseJsonObject(
        UpdateDomainLayoutOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
