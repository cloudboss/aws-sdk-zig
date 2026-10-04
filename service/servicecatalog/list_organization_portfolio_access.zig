const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OrganizationNodeType = @import("organization_node_type.zig").OrganizationNodeType;
const OrganizationNode = @import("organization_node.zig").OrganizationNode;

pub const ListOrganizationPortfolioAccessInput = struct {
    /// The language code.
    ///
    /// * `jp` - Japanese
    ///
    /// * `zh` - Chinese
    accept_language: ?[]const u8 = null,

    /// The organization node type that will be returned in the output.
    ///
    /// * `ORGANIZATION` - Organization that has access to the portfolio.
    ///
    /// * `ORGANIZATIONAL_UNIT` - Organizational unit that has access to the
    ///   portfolio within your organization.
    ///
    /// * `ACCOUNT` - Account that has access to the portfolio within your
    ///   organization.
    organization_node_type: OrganizationNodeType,

    /// The maximum number of items to return with this call.
    page_size: ?i32 = null,

    /// The page token for the next set of results. To retrieve the first set of
    /// results, use null.
    page_token: ?[]const u8 = null,

    /// The portfolio identifier. For example, `port-2abcdext3y5fk`.
    portfolio_id: []const u8,

    pub const json_field_names = .{
        .accept_language = "AcceptLanguage",
        .organization_node_type = "OrganizationNodeType",
        .page_size = "PageSize",
        .page_token = "PageToken",
        .portfolio_id = "PortfolioId",
    };
};

pub const ListOrganizationPortfolioAccessOutput = struct {
    /// The page token to use to retrieve the next set of results. If there are no
    /// additional results, this value is null.
    next_page_token: ?[]const u8 = null,

    /// Displays information about the organization nodes.
    organization_nodes: ?[]const OrganizationNode = null,

    pub const json_field_names = .{
        .next_page_token = "NextPageToken",
        .organization_nodes = "OrganizationNodes",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListOrganizationPortfolioAccessInput, options: CallOptions) !ListOrganizationPortfolioAccessOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListOrganizationPortfolioAccessInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWS242ServiceCatalogService.ListOrganizationPortfolioAccess");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListOrganizationPortfolioAccessOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListOrganizationPortfolioAccessOutput, body, allocator);
}
