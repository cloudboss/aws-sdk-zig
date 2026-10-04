const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DisplayContent = @import("display_content.zig").DisplayContent;

pub const UpdateProductPageInput = struct {
    /// The content of the product page.
    display_content: ?DisplayContent = null,

    /// The portal product identifier.
    portal_product_id: []const u8,

    /// The portal product identifier.
    product_page_id: []const u8,

    pub const json_field_names = .{
        .display_content = "DisplayContent",
        .portal_product_id = "PortalProductId",
        .product_page_id = "ProductPageId",
    };
};

pub const UpdateProductPageOutput = struct {
    /// The content of the product page.
    display_content: ?DisplayContent = null,

    /// The timestamp when the product page was last modified.
    last_modified: ?i64 = null,

    /// The ARN of the product page.
    product_page_arn: ?[]const u8 = null,

    /// The product page identifier.
    product_page_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .display_content = "DisplayContent",
        .last_modified = "LastModified",
        .product_page_arn = "ProductPageArn",
        .product_page_id = "ProductPageId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateProductPageInput, options: CallOptions) !UpdateProductPageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "apigateway", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateProductPageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "ApiGatewayV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/portalproducts/");
    try path_buf.appendSlice(allocator, input.portal_product_id);
    try path_buf.appendSlice(allocator, "/productpages/");
    try path_buf.appendSlice(allocator, input.product_page_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.display_content) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DisplayContent\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateProductPageOutput {
    var result: UpdateProductPageOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateProductPageOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
