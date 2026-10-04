const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Contact = @import("contact.zig").Contact;
const EinvoiceDeliveryPreference = @import("einvoice_delivery_preference.zig").EinvoiceDeliveryPreference;
const MarketplacePunchOutPreference = @import("marketplace_punch_out_preference.zig").MarketplacePunchOutPreference;
const ProcurementPortalPreferenceSelector = @import("procurement_portal_preference_selector.zig").ProcurementPortalPreferenceSelector;
const TestEnvPreferenceInput = @import("test_env_preference_input.zig").TestEnvPreferenceInput;

pub const PutProcurementPortalPreferenceInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure idempotency
    /// of the request.
    client_token: ?[]const u8 = null,

    /// Updated list of contact information for portal administrators and technical
    /// contacts.
    contacts: []const Contact,

    /// Updated flag indicating whether e-invoice delivery is enabled for this
    /// procurement portal preference.
    einvoice_delivery_enabled: bool,

    /// Updated e-invoice delivery configuration including document types,
    /// attachment types, and customization settings for the portal.
    einvoice_delivery_preference: ?EinvoiceDeliveryPreference = null,

    /// Whether Marketplace PunchOut is enabled for this connection. Defaults to
    /// false if not provided.
    marketplace_punch_out_enabled: ?bool = null,

    /// Configuration for Marketplace PunchOut. Required when
    /// MarketplacePunchOutEnabled is true.
    marketplace_punch_out_preference: ?MarketplacePunchOutPreference = null,

    /// The updated endpoint URL where e-invoices will be delivered to the
    /// procurement portal. Must be a valid HTTPS URL.
    procurement_portal_instance_endpoint: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the procurement portal preference to
    /// update.
    procurement_portal_preference_arn: []const u8,

    /// The updated shared secret or authentication credential for the procurement
    /// portal. This value must be encrypted at rest.
    procurement_portal_shared_secret: ?[]const u8 = null,

    /// Updated flag indicating whether purchase order retrieval is enabled for this
    /// procurement portal preference.
    purchase_order_retrieval_enabled: bool,

    selector: ?ProcurementPortalPreferenceSelector = null,

    /// Updated configuration settings for the test environment of the procurement
    /// portal.
    test_env_preference: ?TestEnvPreferenceInput = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .contacts = "Contacts",
        .einvoice_delivery_enabled = "EinvoiceDeliveryEnabled",
        .einvoice_delivery_preference = "EinvoiceDeliveryPreference",
        .marketplace_punch_out_enabled = "MarketplacePunchOutEnabled",
        .marketplace_punch_out_preference = "MarketplacePunchOutPreference",
        .procurement_portal_instance_endpoint = "ProcurementPortalInstanceEndpoint",
        .procurement_portal_preference_arn = "ProcurementPortalPreferenceArn",
        .procurement_portal_shared_secret = "ProcurementPortalSharedSecret",
        .purchase_order_retrieval_enabled = "PurchaseOrderRetrievalEnabled",
        .selector = "Selector",
        .test_env_preference = "TestEnvPreference",
    };
};

pub const PutProcurementPortalPreferenceOutput = struct {
    /// The Amazon Resource Name (ARN) of the updated procurement portal preference.
    procurement_portal_preference_arn: []const u8,

    pub const json_field_names = .{
        .procurement_portal_preference_arn = "ProcurementPortalPreferenceArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutProcurementPortalPreferenceInput, options: CallOptions) !PutProcurementPortalPreferenceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutProcurementPortalPreferenceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Invoicing.PutProcurementPortalPreference");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutProcurementPortalPreferenceOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(PutProcurementPortalPreferenceOutput, body, allocator);
}
