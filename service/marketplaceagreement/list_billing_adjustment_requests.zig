const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BillingAdjustmentStatus = @import("billing_adjustment_status.zig").BillingAdjustmentStatus;
const BillingAdjustmentSummary = @import("billing_adjustment_summary.zig").BillingAdjustmentSummary;

pub const ListBillingAdjustmentRequestsInput = struct {
    /// The unique identifier of the agreement to list billing adjustment requests
    /// for.
    agreement_id: ?[]const u8 = null,

    /// An optional filter to return billing adjustment requests by agreement type
    /// (e.g., `PurchaseAgreement`).
    agreement_type: ?[]const u8 = null,

    /// An optional filter to return billing adjustment requests by catalog (e.g.,
    /// `AWSMarketplace`).
    catalog: ?[]const u8 = null,

    /// An optional filter to return billing adjustment requests created after the
    /// specified timestamp.
    created_after: ?i64 = null,

    /// An optional filter to return billing adjustment requests created before the
    /// specified timestamp.
    created_before: ?i64 = null,

    /// The maximum number of billing adjustment requests to return in the response.
    max_results: ?i32 = null,

    /// A token to specify where to start pagination.
    next_token: ?[]const u8 = null,

    /// An optional filter to return billing adjustment requests with the specified
    /// status.
    status: ?BillingAdjustmentStatus = null,

    pub const json_field_names = .{
        .agreement_id = "agreementId",
        .agreement_type = "agreementType",
        .catalog = "catalog",
        .created_after = "createdAfter",
        .created_before = "createdBefore",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .status = "status",
    };
};

pub const ListBillingAdjustmentRequestsOutput = struct {
    /// An array of `BillingAdjustmentSummary` objects containing summary
    /// information about each billing adjustment request.
    items: ?[]const BillingAdjustmentSummary = null,

    /// The token used for pagination. The field is `null` if there are no more
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "items",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListBillingAdjustmentRequestsInput, options: CallOptions) !ListBillingAdjustmentRequestsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListBillingAdjustmentRequestsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSMPCommerceService_v20200301.ListBillingAdjustmentRequests");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListBillingAdjustmentRequestsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListBillingAdjustmentRequestsOutput, body, allocator);
}
