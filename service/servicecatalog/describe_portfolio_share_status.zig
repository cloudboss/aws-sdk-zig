const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ShareDetails = @import("share_details.zig").ShareDetails;
const ShareStatus = @import("share_status.zig").ShareStatus;

pub const DescribePortfolioShareStatusInput = struct {
    /// The token for the portfolio share operation. This token is returned either
    /// by CreatePortfolioShare or by DeletePortfolioShare.
    portfolio_share_token: []const u8,

    pub const json_field_names = .{
        .portfolio_share_token = "PortfolioShareToken",
    };
};

pub const DescribePortfolioShareStatusOutput = struct {
    /// Organization node identifier. It can be either account id, organizational
    /// unit id or organization id.
    organization_node_value: ?[]const u8 = null,

    /// The portfolio identifier.
    portfolio_id: ?[]const u8 = null,

    /// The token for the portfolio share operation. For example,
    /// `share-6v24abcdefghi`.
    portfolio_share_token: ?[]const u8 = null,

    /// Information about the portfolio share operation.
    share_details: ?ShareDetails = null,

    /// Status of the portfolio share operation.
    status: ?ShareStatus = null,

    pub const json_field_names = .{
        .organization_node_value = "OrganizationNodeValue",
        .portfolio_id = "PortfolioId",
        .portfolio_share_token = "PortfolioShareToken",
        .share_details = "ShareDetails",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribePortfolioShareStatusInput, options: CallOptions) !DescribePortfolioShareStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "servicecatalog", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribePortfolioShareStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("servicecatalog", "Service Catalog", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWS242ServiceCatalogService.DescribePortfolioShareStatus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribePortfolioShareStatusOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribePortfolioShareStatusOutput, body, allocator);
}
