const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkloadEstimateRateType = @import("workload_estimate_rate_type.zig").WorkloadEstimateRateType;
const CurrencyCode = @import("currency_code.zig").CurrencyCode;
const WorkloadEstimateStatus = @import("workload_estimate_status.zig").WorkloadEstimateStatus;

pub const CreateWorkloadEstimateInput = struct {
    /// A unique, case-sensitive identifier to ensure idempotency of the request.
    client_token: ?[]const u8 = null,

    /// A descriptive name for the workload estimate.
    name: []const u8,

    /// The type of pricing rates to use for the estimate.
    rate_type: ?WorkloadEstimateRateType = null,

    /// The tags to apply to the workload estimate.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .name = "name",
        .rate_type = "rateType",
        .tags = "tags",
    };
};

pub const CreateWorkloadEstimateOutput = struct {
    /// The currency of the estimated cost.
    cost_currency: ?CurrencyCode = null,

    /// The timestamp when the workload estimate was created.
    created_at: ?i64 = null,

    /// The timestamp when the workload estimate will expire.
    expires_at: ?i64 = null,

    /// An error message if the workload estimate creation failed.
    failure_message: ?[]const u8 = null,

    /// The unique identifier for the created workload estimate.
    id: []const u8,

    /// The name of the created workload estimate.
    name: ?[]const u8 = null,

    /// The timestamp of the pricing rates used for the estimate.
    rate_timestamp: ?i64 = null,

    /// The type of pricing rates used for the estimate.
    rate_type: ?WorkloadEstimateRateType = null,

    /// The current status of the workload estimate.
    status: ?WorkloadEstimateStatus = null,

    /// The total estimated cost for the workload.
    total_cost: ?f64 = null,

    pub const json_field_names = .{
        .cost_currency = "costCurrency",
        .created_at = "createdAt",
        .expires_at = "expiresAt",
        .failure_message = "failureMessage",
        .id = "id",
        .name = "name",
        .rate_timestamp = "rateTimestamp",
        .rate_type = "rateType",
        .status = "status",
        .total_cost = "totalCost",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWorkloadEstimateInput, options: CallOptions) !CreateWorkloadEstimateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bcm-pricing-calculator", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateWorkloadEstimateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bcm-pricing-calculator", "BCM Pricing Calculator", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSBCMPricingCalculator.CreateWorkloadEstimate");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateWorkloadEstimateOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateWorkloadEstimateOutput, body, allocator);
}
