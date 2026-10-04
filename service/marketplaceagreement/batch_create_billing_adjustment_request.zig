const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchCreateBillingAdjustmentRequestEntry = @import("batch_create_billing_adjustment_request_entry.zig").BatchCreateBillingAdjustmentRequestEntry;
const BatchCreateBillingAdjustmentError = @import("batch_create_billing_adjustment_error.zig").BatchCreateBillingAdjustmentError;
const BatchCreateBillingAdjustmentItem = @import("batch_create_billing_adjustment_item.zig").BatchCreateBillingAdjustmentItem;

pub const BatchCreateBillingAdjustmentRequestInput = struct {
    /// A list of billing adjustment request entries. Each entry specifies the
    /// invoice and adjustment details.
    billing_adjustment_request_entries: []const BatchCreateBillingAdjustmentRequestEntry,

    pub const json_field_names = .{
        .billing_adjustment_request_entries = "billingAdjustmentRequestEntries",
    };
};

pub const BatchCreateBillingAdjustmentRequestOutput = struct {
    /// A list of errors for entries that failed validation, each containing the
    /// `clientToken`, error `code`, and `message`.
    errors: ?[]const BatchCreateBillingAdjustmentError = null,

    /// A list of successfully created billing adjustment items, each containing the
    /// `billingAdjustmentRequestId` and `clientToken`.
    items: ?[]const BatchCreateBillingAdjustmentItem = null,

    pub const json_field_names = .{
        .errors = "errors",
        .items = "items",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchCreateBillingAdjustmentRequestInput, options: CallOptions) !BatchCreateBillingAdjustmentRequestOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsmpcommerceservice_v20200301", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchCreateBillingAdjustmentRequestInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("agreement-marketplace", "Marketplace Agreement", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSMPCommerceService_v20200301.BatchCreateBillingAdjustmentRequest");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchCreateBillingAdjustmentRequestOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(BatchCreateBillingAdjustmentRequestOutput, body, allocator);
}
