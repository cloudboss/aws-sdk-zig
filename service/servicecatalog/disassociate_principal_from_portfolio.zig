const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PrincipalType = @import("principal_type.zig").PrincipalType;

pub const DisassociatePrincipalFromPortfolioInput = struct {
    /// The language code.
    ///
    /// * `jp` - Japanese
    ///
    /// * `zh` - Chinese
    accept_language: ?[]const u8 = null,

    /// The portfolio identifier.
    portfolio_id: []const u8,

    /// The ARN of the principal (user, role, or group). This field allows an ARN
    /// with no `accountID` with or without wildcard characters if
    /// `PrincipalType` is `IAM_PATTERN`.
    principal_arn: []const u8,

    /// The supported value is `IAM` if you use a fully defined ARN, or
    /// `IAM_PATTERN`
    /// if you specify an `IAM` ARN with no AccountId, with or without wildcard
    /// characters.
    principal_type: ?PrincipalType = null,

    pub const json_field_names = .{
        .accept_language = "AcceptLanguage",
        .portfolio_id = "PortfolioId",
        .principal_arn = "PrincipalARN",
        .principal_type = "PrincipalType",
    };
};

pub const DisassociatePrincipalFromPortfolioOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DisassociatePrincipalFromPortfolioInput, options: CallOptions) !DisassociatePrincipalFromPortfolioOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DisassociatePrincipalFromPortfolioInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWS242ServiceCatalogService.DisassociatePrincipalFromPortfolio");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DisassociatePrincipalFromPortfolioOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
