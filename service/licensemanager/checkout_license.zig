const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CheckoutType = @import("checkout_type.zig").CheckoutType;
const EntitlementData = @import("entitlement_data.zig").EntitlementData;

pub const CheckoutLicenseInput = struct {
    /// License beneficiary.
    beneficiary: ?[]const u8 = null,

    /// Checkout type.
    checkout_type: CheckoutType,

    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request.
    client_token: []const u8,

    /// License entitlements.
    entitlements: []const EntitlementData,

    /// Key fingerprint identifying the license.
    key_fingerprint: []const u8,

    /// Node ID.
    node_id: ?[]const u8 = null,

    /// Product SKU.
    product_sku: []const u8,

    pub const json_field_names = .{
        .beneficiary = "Beneficiary",
        .checkout_type = "CheckoutType",
        .client_token = "ClientToken",
        .entitlements = "Entitlements",
        .key_fingerprint = "KeyFingerprint",
        .node_id = "NodeId",
        .product_sku = "ProductSKU",
    };
};

pub const CheckoutLicenseOutput = struct {
    /// Checkout type.
    checkout_type: ?CheckoutType = null,

    /// Allowed license entitlements.
    entitlements_allowed: ?[]const EntitlementData = null,

    /// Date and time at which the license checkout expires.
    expiration: ?[]const u8 = null,

    /// Date and time at which the license checkout is issued.
    issued_at: ?[]const u8 = null,

    /// Amazon Resource Name (ARN) of the checkout license.
    license_arn: ?[]const u8 = null,

    /// License consumption token.
    license_consumption_token: ?[]const u8 = null,

    /// Node ID.
    node_id: ?[]const u8 = null,

    /// Signed token.
    signed_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .checkout_type = "CheckoutType",
        .entitlements_allowed = "EntitlementsAllowed",
        .expiration = "Expiration",
        .issued_at = "IssuedAt",
        .license_arn = "LicenseArn",
        .license_consumption_token = "LicenseConsumptionToken",
        .node_id = "NodeId",
        .signed_token = "SignedToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CheckoutLicenseInput, options: CallOptions) !CheckoutLicenseOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "license-manager", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CheckoutLicenseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("license-manager", "License Manager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSLicenseManager.CheckoutLicense");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CheckoutLicenseOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CheckoutLicenseOutput, body, allocator);
}
