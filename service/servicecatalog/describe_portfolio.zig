const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BudgetDetail = @import("budget_detail.zig").BudgetDetail;
const PortfolioDetail = @import("portfolio_detail.zig").PortfolioDetail;
const TagOptionDetail = @import("tag_option_detail.zig").TagOptionDetail;
const Tag = @import("tag.zig").Tag;

pub const DescribePortfolioInput = struct {
    /// The language code.
    ///
    /// * `jp` - Japanese
    ///
    /// * `zh` - Chinese
    accept_language: ?[]const u8 = null,

    /// The portfolio identifier.
    id: []const u8,

    pub const json_field_names = .{
        .accept_language = "AcceptLanguage",
        .id = "Id",
    };
};

pub const DescribePortfolioOutput = struct {
    /// Information about the associated budgets.
    budgets: ?[]const BudgetDetail = null,

    /// Information about the portfolio.
    portfolio_detail: ?PortfolioDetail = null,

    /// Information about the TagOptions associated with the portfolio.
    tag_options: ?[]const TagOptionDetail = null,

    /// Information about the tags associated with the portfolio.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .budgets = "Budgets",
        .portfolio_detail = "PortfolioDetail",
        .tag_options = "TagOptions",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribePortfolioInput, options: CallOptions) !DescribePortfolioOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribePortfolioInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWS242ServiceCatalogService.DescribePortfolio");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribePortfolioOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribePortfolioOutput, body, allocator);
}
