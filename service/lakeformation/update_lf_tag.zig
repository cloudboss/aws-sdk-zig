const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateLFTagInput = struct {
    /// The identifier for the Data Catalog. By default, the account ID. The Data
    /// Catalog is the persistent metadata store. It contains database definitions,
    /// table definitions, and other control information to manage your Lake
    /// Formation environment.
    catalog_id: ?[]const u8 = null,

    /// The key-name for the LF-tag for which to add or delete values.
    tag_key: []const u8,

    /// A list of LF-tag values to add from the LF-tag.
    tag_values_to_add: ?[]const []const u8 = null,

    /// A list of LF-tag values to delete from the LF-tag.
    tag_values_to_delete: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .tag_key = "TagKey",
        .tag_values_to_add = "TagValuesToAdd",
        .tag_values_to_delete = "TagValuesToDelete",
    };
};

pub const UpdateLFTagOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateLFTagInput, options: CallOptions) !UpdateLFTagOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lakeformation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateLFTagInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lakeformation", "LakeFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/UpdateLFTag";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.catalog_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CatalogId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TagKey\":");
    try aws.json.writeValue(@TypeOf(input.tag_key), input.tag_key, allocator, &body_buf);
    has_prev = true;
    if (input.tag_values_to_add) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TagValuesToAdd\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tag_values_to_delete) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TagValuesToDelete\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateLFTagOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateLFTagOutput = .{};

    return result;
}
