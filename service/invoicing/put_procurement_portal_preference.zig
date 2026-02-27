const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Contact = @import("contact.zig").Contact;
const EinvoiceDeliveryPreference = @import("einvoice_delivery_preference.zig").EinvoiceDeliveryPreference;
const ProcurementPortalPreferenceSelector = @import("procurement_portal_preference_selector.zig").ProcurementPortalPreferenceSelector;
const TestEnvPreferenceInput = @import("test_env_preference_input.zig").TestEnvPreferenceInput;

pub const PutProcurementPortalPreferenceInput = struct {
    /// Updated list of contact information for portal administrators and technical
    /// contacts.
    contacts: []const Contact,

    /// Updated flag indicating whether e-invoice delivery is enabled for this
    /// procurement portal preference.
    einvoice_delivery_enabled: bool,

    /// Updated e-invoice delivery configuration including document types,
    /// attachment types, and customization settings for the portal.
    einvoice_delivery_preference: ?EinvoiceDeliveryPreference = null,

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
        .contacts = "Contacts",
        .einvoice_delivery_enabled = "EinvoiceDeliveryEnabled",
        .einvoice_delivery_preference = "EinvoiceDeliveryPreference",
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutProcurementPortalPreferenceInput, options: Options) !PutProcurementPortalPreferenceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "invoicing");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: PutProcurementPortalPreferenceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("invoicing", "Invoicing", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "Invoicing.PutProcurementPortalPreference");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !PutProcurementPortalPreferenceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutProcurementPortalPreferenceOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
