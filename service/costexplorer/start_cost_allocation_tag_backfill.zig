const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CostAllocationTagBackfillRequest = @import("cost_allocation_tag_backfill_request.zig").CostAllocationTagBackfillRequest;

pub const StartCostAllocationTagBackfillInput = struct {
    /// The date you want the backfill to start from. The date can only be a first
    /// day of the month (a billing start date). Dates can't precede the previous
    /// twelve months, or in the future.
    backfill_from: []const u8,

    pub const json_field_names = .{
        .backfill_from = "BackfillFrom",
    };
};

pub const StartCostAllocationTagBackfillOutput = struct {
    /// An object containing detailed metadata of your new backfill request.
    backfill_request: ?CostAllocationTagBackfillRequest = null,

    pub const json_field_names = .{
        .backfill_request = "BackfillRequest",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartCostAllocationTagBackfillInput, options: CallOptions) !StartCostAllocationTagBackfillOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ce", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartCostAllocationTagBackfillInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ce", "Cost Explorer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSInsightsIndexService.StartCostAllocationTagBackfill");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartCostAllocationTagBackfillOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartCostAllocationTagBackfillOutput, body, allocator);
}
