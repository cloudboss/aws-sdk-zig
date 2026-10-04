const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EndpointDisplayContentResponse = @import("endpoint_display_content_response.zig").EndpointDisplayContentResponse;
const RestEndpointIdentifier = @import("rest_endpoint_identifier.zig").RestEndpointIdentifier;
const Status = @import("status.zig").Status;
const StatusException = @import("status_exception.zig").StatusException;
const TryItState = @import("try_it_state.zig").TryItState;

pub const GetProductRestEndpointPageInput = struct {
    /// The query parameter to include raw display content.
    include_raw_display_content: ?[]const u8 = null,

    /// The portal product identifier.
    portal_product_id: []const u8,

    /// The product REST endpoint identifier.
    product_rest_endpoint_page_id: []const u8,

    /// The account ID of the resource owner of the portal product.
    resource_owner_account_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .include_raw_display_content = "IncludeRawDisplayContent",
        .portal_product_id = "PortalProductId",
        .product_rest_endpoint_page_id = "ProductRestEndpointPageId",
        .resource_owner_account_id = "ResourceOwnerAccountId",
    };
};

pub const GetProductRestEndpointPageOutput = struct {
    /// The content of the product REST endpoint page.
    display_content: ?EndpointDisplayContentResponse = null,

    /// The timestamp when the product REST endpoint page was last modified.
    last_modified: ?i64 = null,

    /// The ARN of the product REST endpoint page.
    product_rest_endpoint_page_arn: ?[]const u8 = null,

    /// The product REST endpoint page identifier.
    product_rest_endpoint_page_id: ?[]const u8 = null,

    /// The raw display content of the product REST endpoint page.
    raw_display_content: ?[]const u8 = null,

    /// The REST endpoint identifier.
    rest_endpoint_identifier: ?RestEndpointIdentifier = null,

    /// The status of the product REST endpoint page.
    status: ?Status = null,

    /// The status exception information.
    status_exception: ?StatusException = null,

    /// The try it state.
    try_it_state: ?TryItState = null,

    pub const json_field_names = .{
        .display_content = "DisplayContent",
        .last_modified = "LastModified",
        .product_rest_endpoint_page_arn = "ProductRestEndpointPageArn",
        .product_rest_endpoint_page_id = "ProductRestEndpointPageId",
        .raw_display_content = "RawDisplayContent",
        .rest_endpoint_identifier = "RestEndpointIdentifier",
        .status = "Status",
        .status_exception = "StatusException",
        .try_it_state = "TryItState",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetProductRestEndpointPageInput, options: CallOptions) !GetProductRestEndpointPageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetProductRestEndpointPageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "ApiGatewayV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/portalproducts/");
    try path_buf.appendSlice(allocator, input.portal_product_id);
    try path_buf.appendSlice(allocator, "/productrestendpointpages/");
    try path_buf.appendSlice(allocator, input.product_rest_endpoint_page_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.include_raw_display_content) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "includeRawDisplayContent=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.resource_owner_account_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "resourceOwnerAccountId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetProductRestEndpointPageOutput {
    const result: GetProductRestEndpointPageOutput = try aws.json.parseJsonObject(
        GetProductRestEndpointPageOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
