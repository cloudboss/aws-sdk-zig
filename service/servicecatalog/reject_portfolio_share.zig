const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PortfolioShareType = @import("portfolio_share_type.zig").PortfolioShareType;

pub const RejectPortfolioShareInput = struct {
    /// The language code.
    ///
    /// * `jp` - Japanese
    ///
    /// * `zh` - Chinese
    accept_language: ?[]const u8 = null,

    /// The portfolio identifier.
    portfolio_id: []const u8,

    /// The type of shared portfolios to reject. The default is to reject imported
    /// portfolios.
    ///
    /// * `AWS_ORGANIZATIONS` - Reject portfolios shared by the management account
    ///   of your
    /// organization.
    ///
    /// * `IMPORTED` - Reject imported portfolios.
    ///
    /// * `AWS_SERVICECATALOG` - Not supported. (Throws ResourceNotFoundException.)
    ///
    /// For example, `aws servicecatalog reject-portfolio-share --portfolio-id
    /// "port-2qwzkwxt3y5fk" --portfolio-share-type AWS_ORGANIZATIONS`
    portfolio_share_type: ?PortfolioShareType = null,

    pub const json_field_names = .{
        .accept_language = "AcceptLanguage",
        .portfolio_id = "PortfolioId",
        .portfolio_share_type = "PortfolioShareType",
    };
};

pub const RejectPortfolioShareOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RejectPortfolioShareInput, options: CallOptions) !RejectPortfolioShareOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RejectPortfolioShareInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWS242ServiceCatalogService.RejectPortfolioShare");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RejectPortfolioShareOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
