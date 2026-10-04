const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BuyerDomain = @import("buyer_domain.zig").BuyerDomain;
const Contact = @import("contact.zig").Contact;
const EinvoiceDeliveryPreference = @import("einvoice_delivery_preference.zig").EinvoiceDeliveryPreference;
const MarketplacePunchOutPreference = @import("marketplace_punch_out_preference.zig").MarketplacePunchOutPreference;
const ProcurementPortalName = @import("procurement_portal_name.zig").ProcurementPortalName;
const ResourceTag = @import("resource_tag.zig").ResourceTag;
const ProcurementPortalPreferenceSelector = @import("procurement_portal_preference_selector.zig").ProcurementPortalPreferenceSelector;
const SupplierDomain = @import("supplier_domain.zig").SupplierDomain;
const TestEnvPreferenceInput = @import("test_env_preference_input.zig").TestEnvPreferenceInput;

pub const CreateProcurementPortalPreferenceInput = struct {
    /// The domain identifier for the buyer in the procurement portal.
    buyer_domain: BuyerDomain,

    /// The unique identifier for the buyer in the procurement portal.
    buyer_identifier: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure idempotency
    /// of the request.
    client_token: ?[]const u8 = null,

    /// List of contact information for portal administrators and technical contacts
    /// responsible for the e-invoice integration.
    contacts: []const Contact,

    /// Indicates whether e-invoice delivery is enabled for this procurement portal
    /// preference. Set to true to enable e-invoice delivery, false to disable.
    einvoice_delivery_enabled: bool,

    /// Specifies the e-invoice delivery configuration including document types,
    /// attachment types, and customization settings for the portal.
    einvoice_delivery_preference: ?EinvoiceDeliveryPreference = null,

    /// Defaults to false if not provided.
    marketplace_punch_out_enabled: ?bool = null,

    /// Required for Coupa when MarketplacePunchOutEnabled is true.
    marketplace_punch_out_preference: ?MarketplacePunchOutPreference = null,

    /// The endpoint URL where e-invoices will be delivered to the procurement
    /// portal. Must be a valid HTTPS URL.
    procurement_portal_instance_endpoint: ?[]const u8 = null,

    /// The name of the procurement portal.
    procurement_portal_name: ProcurementPortalName,

    /// The shared secret or authentication credential used to establish secure
    /// communication with the procurement portal. This value must be encrypted at
    /// rest.
    procurement_portal_shared_secret: ?[]const u8 = null,

    /// Indicates whether purchase order retrieval is enabled for this procurement
    /// portal preference. Set to true to enable PO retrieval, false to disable.
    purchase_order_retrieval_enabled: bool,

    /// The tags to apply to this procurement portal preference resource. Each tag
    /// consists of a key and an optional value.
    resource_tags: ?[]const ResourceTag = null,

    selector: ?ProcurementPortalPreferenceSelector = null,

    /// The domain identifier for the supplier in the procurement portal.
    supplier_domain: SupplierDomain,

    /// The unique identifier for the supplier in the procurement portal.
    supplier_identifier: []const u8,

    /// Configuration settings for the test environment of the procurement portal.
    /// Includes test credentials and endpoints that are used for validation before
    /// production deployment.
    test_env_preference: ?TestEnvPreferenceInput = null,

    pub const json_field_names = .{
        .buyer_domain = "BuyerDomain",
        .buyer_identifier = "BuyerIdentifier",
        .client_token = "ClientToken",
        .contacts = "Contacts",
        .einvoice_delivery_enabled = "EinvoiceDeliveryEnabled",
        .einvoice_delivery_preference = "EinvoiceDeliveryPreference",
        .marketplace_punch_out_enabled = "MarketplacePunchOutEnabled",
        .marketplace_punch_out_preference = "MarketplacePunchOutPreference",
        .procurement_portal_instance_endpoint = "ProcurementPortalInstanceEndpoint",
        .procurement_portal_name = "ProcurementPortalName",
        .procurement_portal_shared_secret = "ProcurementPortalSharedSecret",
        .purchase_order_retrieval_enabled = "PurchaseOrderRetrievalEnabled",
        .resource_tags = "ResourceTags",
        .selector = "Selector",
        .supplier_domain = "SupplierDomain",
        .supplier_identifier = "SupplierIdentifier",
        .test_env_preference = "TestEnvPreference",
    };
};

pub const CreateProcurementPortalPreferenceOutput = struct {
    /// The Amazon Resource Name (ARN) of the created procurement portal preference.
    procurement_portal_preference_arn: []const u8,

    pub const json_field_names = .{
        .procurement_portal_preference_arn = "ProcurementPortalPreferenceArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateProcurementPortalPreferenceInput, options: CallOptions) !CreateProcurementPortalPreferenceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateProcurementPortalPreferenceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Invoicing.CreateProcurementPortalPreference");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateProcurementPortalPreferenceOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateProcurementPortalPreferenceOutput, body, allocator);
}
