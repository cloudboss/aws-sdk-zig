const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OrganizationNode = @import("organization_node.zig").OrganizationNode;
const ShareStatus = @import("share_status.zig").ShareStatus;

pub const UpdatePortfolioShareInput = struct {
    /// The language code.
    ///
    /// * `jp` - Japanese
    ///
    /// * `zh` - Chinese
    accept_language: ?[]const u8 = null,

    /// The Amazon Web Services account Id of the recipient account. This field is
    /// required when updating an external account to account type share.
    account_id: ?[]const u8 = null,

    organization_node: ?OrganizationNode = null,

    /// The unique identifier of the portfolio for which the share will be updated.
    portfolio_id: []const u8,

    /// A flag to enables or disables `Principals` sharing in the portfolio. If this
    /// field is not provided,
    /// the current state of the `Principals` sharing on the portfolio share will
    /// not be modified.
    share_principals: ?bool = null,

    /// Enables or disables `TagOptions` sharing for the portfolio share. If this
    /// field is not provided, the current state of
    /// TagOptions sharing on the portfolio share will not be modified.
    share_tag_options: ?bool = null,

    pub const json_field_names = .{
        .accept_language = "AcceptLanguage",
        .account_id = "AccountId",
        .organization_node = "OrganizationNode",
        .portfolio_id = "PortfolioId",
        .share_principals = "SharePrincipals",
        .share_tag_options = "ShareTagOptions",
    };
};

pub const UpdatePortfolioShareOutput = struct {
    /// The token that tracks the status of the `UpdatePortfolioShare` operation for
    /// external account to account or organizational type sharing.
    portfolio_share_token: ?[]const u8 = null,

    /// The status of `UpdatePortfolioShare` operation.
    /// You can also obtain the operation status using
    /// `DescribePortfolioShareStatus` API.
    status: ?ShareStatus = null,

    pub const json_field_names = .{
        .portfolio_share_token = "PortfolioShareToken",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePortfolioShareInput, options: CallOptions) !UpdatePortfolioShareOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePortfolioShareInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWS242ServiceCatalogService.UpdatePortfolioShare");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePortfolioShareOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdatePortfolioShareOutput, body, allocator);
}
