const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OrganizationNode = @import("organization_node.zig").OrganizationNode;

pub const DeletePortfolioShareInput = struct {
    /// The language code.
    ///
    /// * `jp` - Japanese
    ///
    /// * `zh` - Chinese
    accept_language: ?[]const u8 = null,

    /// The Amazon Web Services account ID.
    account_id: ?[]const u8 = null,

    /// The organization node to whom you are going to stop sharing.
    organization_node: ?OrganizationNode = null,

    /// The portfolio identifier.
    portfolio_id: []const u8,

    pub const json_field_names = .{
        .accept_language = "AcceptLanguage",
        .account_id = "AccountId",
        .organization_node = "OrganizationNode",
        .portfolio_id = "PortfolioId",
    };
};

pub const DeletePortfolioShareOutput = struct {
    /// The portfolio share unique identifier. This will only be returned if delete
    /// is made to an organization node.
    portfolio_share_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .portfolio_share_token = "PortfolioShareToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeletePortfolioShareInput, options: CallOptions) !DeletePortfolioShareOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeletePortfolioShareInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWS242ServiceCatalogService.DeletePortfolioShare");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeletePortfolioShareOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeletePortfolioShareOutput, body, allocator);
}
