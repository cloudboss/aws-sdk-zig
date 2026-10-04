const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PartnerSummary = @import("partner_summary.zig").PartnerSummary;

pub const ListPartnersInput = struct {
    /// The catalog identifier to list partners from.
    catalog: []const u8,

    /// The token for retrieving the next page of results in paginated responses.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .next_token = "NextToken",
    };
};

pub const ListPartnersOutput = struct {
    /// The token for retrieving the next page of results if more results are
    /// available.
    next_token: ?[]const u8 = null,

    /// A list of partner summaries including basic information about each partner
    /// account.
    partner_summary_list: ?[]const PartnerSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .partner_summary_list = "PartnerSummaryList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPartnersInput, options: CallOptions) !ListPartnersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "partnercentral", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPartnersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentral-account", "PartnerCentral Account", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PartnerCentralAccount.ListPartners");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPartnersOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListPartnersOutput, body, allocator);
}
