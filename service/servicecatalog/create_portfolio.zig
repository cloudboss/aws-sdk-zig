const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const PortfolioDetail = @import("portfolio_detail.zig").PortfolioDetail;

pub const CreatePortfolioInput = struct {
    /// The language code.
    ///
    /// * `jp` - Japanese
    ///
    /// * `zh` - Chinese
    accept_language: ?[]const u8 = null,

    /// The description of the portfolio.
    description: ?[]const u8 = null,

    /// The name to use for display purposes.
    display_name: []const u8,

    /// A unique identifier that you provide to ensure idempotency. If multiple
    /// requests differ only by the idempotency token,
    /// the same response is returned for each repeated request.
    idempotency_token: []const u8,

    /// The name of the portfolio provider.
    provider_name: []const u8,

    /// One or more tags.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .accept_language = "AcceptLanguage",
        .description = "Description",
        .display_name = "DisplayName",
        .idempotency_token = "IdempotencyToken",
        .provider_name = "ProviderName",
        .tags = "Tags",
    };
};

pub const CreatePortfolioOutput = struct {
    /// Information about the portfolio.
    portfolio_detail: ?PortfolioDetail = null,

    /// Information about the tags associated with the portfolio.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .portfolio_detail = "PortfolioDetail",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePortfolioInput, options: CallOptions) !CreatePortfolioOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePortfolioInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWS242ServiceCatalogService.CreatePortfolio");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePortfolioOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreatePortfolioOutput, body, allocator);
}
