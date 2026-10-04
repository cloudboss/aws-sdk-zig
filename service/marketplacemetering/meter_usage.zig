const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UsageAllocation = @import("usage_allocation.zig").UsageAllocation;

pub const MeterUsageInput = struct {
    /// Specifies a unique, case-sensitive identifier that you provide to ensure the
    /// idempotency
    /// of the request. This lets you safely retry the request without accidentally
    /// performing the
    /// same operation a second time. Passing the same value to a later call to an
    /// operation
    /// requires that you also pass the same value for all other parameters. We
    /// recommend that you
    /// use a [UUID type of
    /// value](https://wikipedia.org/wiki/Universally_unique_identifier).
    ///
    /// If you don't provide this value, then Amazon Web Services generates a random
    /// one for
    /// you.
    ///
    /// If you retry the operation with the same `ClientToken`, but with different
    /// parameters, the retry fails with an `IdempotencyConflictException` error.
    client_token: ?[]const u8 = null,

    /// Checks whether you have the permissions required for the action, but does
    /// not make the
    /// request. If you have the permissions, the request returns `DryRunOperation`;
    /// otherwise, it returns `UnauthorizedException`. Defaults to `false`
    /// if not specified.
    dry_run: ?bool = null,

    /// Product code is used to uniquely identify a product in Amazon Web Services
    /// Marketplace. The product code
    /// should be the same as the one used during the publishing of a new product.
    product_code: []const u8,

    /// Timestamp, in UTC, for which the usage is being reported. Your application
    /// can meter
    /// usage for up to six hours in the past. Make sure the `timestamp` value is
    /// not
    /// before the start of the software usage.
    timestamp: i64,

    /// The set of `UsageAllocations` to submit.
    ///
    /// The sum of all `UsageAllocation` quantities must equal the
    /// `UsageQuantity` of the `MeterUsage` request, and each
    /// `UsageAllocation` must have a unique set of tags (include no
    /// tags).
    usage_allocations: ?[]const UsageAllocation = null,

    /// It will be one of the fcp dimension name provided during the publishing of
    /// the
    /// product.
    usage_dimension: []const u8,

    /// Consumption value for the hour. Defaults to `0` if not specified.
    usage_quantity: ?i32 = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .dry_run = "DryRun",
        .product_code = "ProductCode",
        .timestamp = "Timestamp",
        .usage_allocations = "UsageAllocations",
        .usage_dimension = "UsageDimension",
        .usage_quantity = "UsageQuantity",
    };
};

pub const MeterUsageOutput = struct {
    /// Metering record id.
    metering_record_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .metering_record_id = "MeteringRecordId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: MeterUsageInput, options: CallOptions) !MeterUsageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: MeterUsageInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSMPMeteringService.MeterUsage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !MeterUsageOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(MeterUsageOutput, body, allocator);
}
