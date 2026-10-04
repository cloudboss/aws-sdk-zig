const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PortfolioShareType = @import("portfolio_share_type.zig").PortfolioShareType;
const PortfolioDetail = @import("portfolio_detail.zig").PortfolioDetail;

pub const ListAcceptedPortfolioSharesInput = struct {
    /// The language code.
    ///
    /// * `jp` - Japanese
    ///
    /// * `zh` - Chinese
    accept_language: ?[]const u8 = null,

    /// The maximum number of items to return with this call.
    page_size: ?i32 = null,

    /// The page token for the next set of results. To retrieve the first set of
    /// results, use null.
    page_token: ?[]const u8 = null,

    /// The type of shared portfolios to list. The default is to list imported
    /// portfolios.
    ///
    /// * `AWS_ORGANIZATIONS` - List portfolios accepted and shared via
    ///   organizational sharing by the management account or delegated
    ///   administrator of your organization.
    ///
    /// * `AWS_SERVICECATALOG` - Deprecated type.
    ///
    /// * `IMPORTED` - List imported portfolios that have been accepted and
    /// shared through account-to-account sharing.
    portfolio_share_type: ?PortfolioShareType = null,

    pub const json_field_names = .{
        .accept_language = "AcceptLanguage",
        .page_size = "PageSize",
        .page_token = "PageToken",
        .portfolio_share_type = "PortfolioShareType",
    };
};

pub const ListAcceptedPortfolioSharesOutput = struct {
    /// The page token to use to retrieve the next set of results. If there are no
    /// additional results, this value is null.
    next_page_token: ?[]const u8 = null,

    /// Information about the portfolios.
    portfolio_details: ?[]const PortfolioDetail = null,

    pub const json_field_names = .{
        .next_page_token = "NextPageToken",
        .portfolio_details = "PortfolioDetails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAcceptedPortfolioSharesInput, options: CallOptions) !ListAcceptedPortfolioSharesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAcceptedPortfolioSharesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWS242ServiceCatalogService.ListAcceptedPortfolioShares");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAcceptedPortfolioSharesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListAcceptedPortfolioSharesOutput, body, allocator);
}
