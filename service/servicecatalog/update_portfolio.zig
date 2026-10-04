const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const PortfolioDetail = @import("portfolio_detail.zig").PortfolioDetail;

pub const UpdatePortfolioInput = struct {
    /// The language code.
    ///
    /// * `jp` - Japanese
    ///
    /// * `zh` - Chinese
    accept_language: ?[]const u8 = null,

    /// The tags to add.
    add_tags: ?[]const Tag = null,

    /// The updated description of the portfolio.
    description: ?[]const u8 = null,

    /// The name to use for display purposes.
    display_name: ?[]const u8 = null,

    /// The portfolio identifier.
    id: []const u8,

    /// The updated name of the portfolio provider.
    provider_name: ?[]const u8 = null,

    /// The tags to remove.
    remove_tags: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .accept_language = "AcceptLanguage",
        .add_tags = "AddTags",
        .description = "Description",
        .display_name = "DisplayName",
        .id = "Id",
        .provider_name = "ProviderName",
        .remove_tags = "RemoveTags",
    };
};

pub const UpdatePortfolioOutput = struct {
    /// Information about the portfolio.
    portfolio_detail: ?PortfolioDetail = null,

    /// Information about the tags associated with the portfolio.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .portfolio_detail = "PortfolioDetail",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePortfolioInput, options: CallOptions) !UpdatePortfolioOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePortfolioInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWS242ServiceCatalogService.UpdatePortfolio");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePortfolioOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdatePortfolioOutput, body, allocator);
}
