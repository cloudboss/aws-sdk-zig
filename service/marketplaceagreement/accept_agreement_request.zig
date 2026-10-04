const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PurchaseOrder = @import("purchase_order.zig").PurchaseOrder;

pub const AcceptAgreementRequestInput = struct {
    /// The unique identifier of the agreement request.
    agreement_request_id: []const u8,

    /// A list of purchase orders associated with accepting a marketplace agreement
    /// request.
    purchase_orders: ?[]const PurchaseOrder = null,

    pub const json_field_names = .{
        .agreement_request_id = "agreementRequestId",
        .purchase_orders = "purchaseOrders",
    };
};

pub const AcceptAgreementRequestOutput = struct {
    /// The unique identifier of the agreement created or modified by accepting the
    /// agreement request.
    agreement_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .agreement_id = "agreementId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AcceptAgreementRequestInput, options: CallOptions) !AcceptAgreementRequestOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AcceptAgreementRequestInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSMPCommerceService_v20200301.AcceptAgreementRequest");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AcceptAgreementRequestOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(AcceptAgreementRequestOutput, body, allocator);
}
