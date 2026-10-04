const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProcurementPortalPreferenceStatus = @import("procurement_portal_preference_status.zig").ProcurementPortalPreferenceStatus;

pub const UpdateProcurementPortalPreferenceStatusInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure idempotency
    /// of the request.
    client_token: ?[]const u8 = null,

    /// The updated status of the e-invoice delivery preference.
    einvoice_delivery_preference_status: ?ProcurementPortalPreferenceStatus = null,

    /// The reason for the e-invoice delivery preference status update, providing
    /// context for the change.
    einvoice_delivery_preference_status_reason: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the procurement portal preference to
    /// update.
    procurement_portal_preference_arn: []const u8,

    /// The updated status of the purchase order retrieval preference.
    purchase_order_retrieval_preference_status: ?ProcurementPortalPreferenceStatus = null,

    /// The reason for the purchase order retrieval preference status update,
    /// providing context for the change.
    purchase_order_retrieval_preference_status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .einvoice_delivery_preference_status = "EinvoiceDeliveryPreferenceStatus",
        .einvoice_delivery_preference_status_reason = "EinvoiceDeliveryPreferenceStatusReason",
        .procurement_portal_preference_arn = "ProcurementPortalPreferenceArn",
        .purchase_order_retrieval_preference_status = "PurchaseOrderRetrievalPreferenceStatus",
        .purchase_order_retrieval_preference_status_reason = "PurchaseOrderRetrievalPreferenceStatusReason",
    };
};

pub const UpdateProcurementPortalPreferenceStatusOutput = struct {
    /// The Amazon Resource Name (ARN) of the procurement portal preference with
    /// updated status.
    procurement_portal_preference_arn: []const u8,

    pub const json_field_names = .{
        .procurement_portal_preference_arn = "ProcurementPortalPreferenceArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateProcurementPortalPreferenceStatusInput, options: CallOptions) !UpdateProcurementPortalPreferenceStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "invoicing", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateProcurementPortalPreferenceStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("invoicing", "Invoicing", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "Invoicing.UpdateProcurementPortalPreferenceStatus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateProcurementPortalPreferenceStatusOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateProcurementPortalPreferenceStatusOutput, body, allocator);
}
