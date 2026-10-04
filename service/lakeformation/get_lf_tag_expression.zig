const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LFTag = @import("lf_tag.zig").LFTag;

pub const GetLFTagExpressionInput = struct {
    /// The identifier for the Data Catalog. By default, the account ID.
    catalog_id: ?[]const u8 = null,

    /// The name for the LF-Tag expression
    name: []const u8,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .name = "Name",
    };
};

pub const GetLFTagExpressionOutput = struct {
    /// The identifier for the Data Catalog. By default, the account ID in which the
    /// LF-Tag expression is saved.
    catalog_id: ?[]const u8 = null,

    /// The description with information about the LF-Tag expression.
    description: ?[]const u8 = null,

    /// The body of the LF-Tag expression. It is composed of one or more LF-Tag
    /// key-value pairs.
    expression: ?[]const LFTag = null,

    /// The name for the LF-Tag expression.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .description = "Description",
        .expression = "Expression",
        .name = "Name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetLFTagExpressionInput, options: CallOptions) !GetLFTagExpressionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetLFTagExpressionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lakeformation", "LakeFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/GetLFTagExpression";

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
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetLFTagExpressionOutput {
    var result: GetLFTagExpressionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetLFTagExpressionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
