const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EndpointDisplayContent = @import("endpoint_display_content.zig").EndpointDisplayContent;
const TryItState = @import("try_it_state.zig").TryItState;
const EndpointDisplayContentResponse = @import("endpoint_display_content_response.zig").EndpointDisplayContentResponse;
const RestEndpointIdentifier = @import("rest_endpoint_identifier.zig").RestEndpointIdentifier;
const Status = @import("status.zig").Status;
const StatusException = @import("status_exception.zig").StatusException;

pub const UpdateProductRestEndpointPageInput = struct {
    /// The display content.
    display_content: ?EndpointDisplayContent = null,

    /// The portal product identifier.
    portal_product_id: []const u8,

    /// The product REST endpoint identifier.
    product_rest_endpoint_page_id: []const u8,

    /// The try it state of a product REST endpoint page.
    try_it_state: ?TryItState = null,

    pub const json_field_names = .{
        .display_content = "DisplayContent",
        .portal_product_id = "PortalProductId",
        .product_rest_endpoint_page_id = "ProductRestEndpointPageId",
        .try_it_state = "TryItState",
    };
};

pub const UpdateProductRestEndpointPageOutput = struct {
    /// The content of the product REST endpoint page.
    display_content: ?EndpointDisplayContentResponse = null,

    /// The timestamp when the product REST endpoint page was last modified.
    last_modified: ?i64 = null,

    /// The ARN of the product REST endpoint page.
    product_rest_endpoint_page_arn: ?[]const u8 = null,

    /// The product REST endpoint page identifier.
    product_rest_endpoint_page_id: ?[]const u8 = null,

    /// The REST endpoint identifier.
    rest_endpoint_identifier: ?RestEndpointIdentifier = null,

    /// The status.
    status: ?Status = null,

    /// The status exception information.
    status_exception: ?StatusException = null,

    /// The try it state of a product REST endpoint page.
    try_it_state: ?TryItState = null,

    pub const json_field_names = .{
        .display_content = "DisplayContent",
        .last_modified = "LastModified",
        .product_rest_endpoint_page_arn = "ProductRestEndpointPageArn",
        .product_rest_endpoint_page_id = "ProductRestEndpointPageId",
        .rest_endpoint_identifier = "RestEndpointIdentifier",
        .status = "Status",
        .status_exception = "StatusException",
        .try_it_state = "TryItState",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateProductRestEndpointPageInput, options: CallOptions) !UpdateProductRestEndpointPageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateProductRestEndpointPageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "ApiGatewayV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/portalproducts/");
    try path_buf.appendSlice(allocator, input.portal_product_id);
    try path_buf.appendSlice(allocator, "/productrestendpointpages/");
    try path_buf.appendSlice(allocator, input.product_rest_endpoint_page_id);
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
    if (input.try_it_state) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TryItState\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateProductRestEndpointPageOutput {
    var result: UpdateProductRestEndpointPageOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateProductRestEndpointPageOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
