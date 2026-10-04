const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FulfillmentType = @import("fulfillment_type.zig").FulfillmentType;
const BenefitAllocationStatus = @import("benefit_allocation_status.zig").BenefitAllocationStatus;
const BenefitAllocationSummary = @import("benefit_allocation_summary.zig").BenefitAllocationSummary;

pub const ListBenefitAllocationsInput = struct {
    /// Filter benefit allocations by specific benefit application identifiers.
    benefit_application_identifiers: ?[]const []const u8 = null,

    /// Filter benefit allocations by specific benefit identifiers.
    benefit_identifiers: ?[]const []const u8 = null,

    /// The catalog identifier to filter benefit allocations by catalog.
    catalog: []const u8,

    /// Filter benefit allocations by specific fulfillment types.
    fulfillment_types: ?[]const FulfillmentType = null,

    /// The maximum number of benefit allocations to return in a single response.
    max_results: ?i32 = null,

    /// A pagination token to retrieve the next set of results from a previous
    /// request.
    next_token: ?[]const u8 = null,

    /// Filter benefit allocations by their current status.
    status: ?[]const BenefitAllocationStatus = null,

    pub const json_field_names = .{
        .benefit_application_identifiers = "BenefitApplicationIdentifiers",
        .benefit_identifiers = "BenefitIdentifiers",
        .catalog = "Catalog",
        .fulfillment_types = "FulfillmentTypes",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .status = "Status",
    };
};

pub const ListBenefitAllocationsOutput = struct {
    /// A list of benefit allocation summaries matching the specified criteria.
    benefit_allocation_summaries: ?[]const BenefitAllocationSummary = null,

    /// A pagination token to retrieve the next set of results, if more results are
    /// available.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .benefit_allocation_summaries = "BenefitAllocationSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListBenefitAllocationsInput, options: CallOptions) !ListBenefitAllocationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListBenefitAllocationsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PartnerCentralBenefitsService.ListBenefitAllocations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListBenefitAllocationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListBenefitAllocationsOutput, body, allocator);
}
