const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FulfillmentType = @import("fulfillment_type.zig").FulfillmentType;
const BenefitStatus = @import("benefit_status.zig").BenefitStatus;
const BenefitSummary = @import("benefit_summary.zig").BenefitSummary;

pub const ListBenefitsInput = struct {
    /// The catalog identifier to filter benefits by catalog.
    catalog: []const u8,

    /// Filter benefits by specific fulfillment types.
    fulfillment_types: ?[]const FulfillmentType = null,

    /// The maximum number of benefits to return in a single response.
    max_results: ?i32 = null,

    /// A pagination token to retrieve the next set of results from a previous
    /// request.
    next_token: ?[]const u8 = null,

    /// Filter benefits by specific AWS partner programs.
    programs: ?[]const []const u8 = null,

    /// Filter benefits by their current status.
    status: ?[]const BenefitStatus = null,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .fulfillment_types = "FulfillmentTypes",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .programs = "Programs",
        .status = "Status",
    };
};

pub const ListBenefitsOutput = struct {
    /// A list of benefit summaries matching the specified criteria.
    benefit_summaries: ?[]const BenefitSummary = null,

    /// A pagination token to retrieve the next set of results, if more results are
    /// available.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .benefit_summaries = "BenefitSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListBenefitsInput, options: CallOptions) !ListBenefitsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListBenefitsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentral-benefits", "PartnerCentral Benefits", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PartnerCentralBenefitsService.ListBenefits");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListBenefitsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListBenefitsOutput, body, allocator);
}
