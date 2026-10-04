const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UsageRecord = @import("usage_record.zig").UsageRecord;
const UsageRecordResult = @import("usage_record_result.zig").UsageRecordResult;

pub const BatchMeterUsageInput = struct {
    /// Product code is used to uniquely identify a product in Amazon Web Services
    /// Marketplace. The product code should
    /// be the same as the one used during the publishing of a new product.
    product_code: ?[]const u8 = null,

    /// The set of `UsageRecords` to submit. `BatchMeterUsage` accepts
    /// up to 25 `UsageRecords` at a time.
    usage_records: []const UsageRecord,

    pub const json_field_names = .{
        .product_code = "ProductCode",
        .usage_records = "UsageRecords",
    };
};

pub const BatchMeterUsageOutput = struct {
    /// Contains all `UsageRecords` processed by `BatchMeterUsage`.
    /// These records were either honored by Amazon Web Services Marketplace
    /// Metering Service or were invalid. Invalid
    /// records should be fixed before being resubmitted.
    results: ?[]const UsageRecordResult = null,

    /// Contains all `UsageRecords` that were not processed by
    /// `BatchMeterUsage`. This is a list of `UsageRecords`. You can
    /// retry the failed request by making another `BatchMeterUsage` call with this
    /// list as input in the `BatchMeterUsageRequest`.
    unprocessed_records: ?[]const UsageRecord = null,

    pub const json_field_names = .{
        .results = "Results",
        .unprocessed_records = "UnprocessedRecords",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchMeterUsageInput, options: CallOptions) !BatchMeterUsageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aws-marketplace", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchMeterUsageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("metering.marketplace", "Marketplace Metering", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSMPMeteringService.BatchMeterUsage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchMeterUsageOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchMeterUsageOutput, body, allocator);
}
