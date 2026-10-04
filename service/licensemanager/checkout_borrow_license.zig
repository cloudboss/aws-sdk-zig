const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Metadata = @import("metadata.zig").Metadata;
const DigitalSignatureMethod = @import("digital_signature_method.zig").DigitalSignatureMethod;
const EntitlementData = @import("entitlement_data.zig").EntitlementData;

pub const CheckoutBorrowLicenseInput = struct {
    /// Information about constraints.
    checkout_metadata: ?[]const Metadata = null,

    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request.
    client_token: []const u8,

    /// Digital signature method. The possible value is JSON Web Signature (JWS)
    /// algorithm PS384.
    /// For more information, see [RFC 7518 Digital Signature with
    /// RSASSA-PSS](https://tools.ietf.org/html/rfc7518#section-3.5).
    digital_signature_method: DigitalSignatureMethod,

    /// License entitlements. Partial checkouts are not supported.
    entitlements: []const EntitlementData,

    /// Amazon Resource Name (ARN) of the license. The license must use the borrow
    /// consumption configuration.
    license_arn: []const u8,

    /// Node ID.
    node_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .checkout_metadata = "CheckoutMetadata",
        .client_token = "ClientToken",
        .digital_signature_method = "DigitalSignatureMethod",
        .entitlements = "Entitlements",
        .license_arn = "LicenseArn",
        .node_id = "NodeId",
    };
};

pub const CheckoutBorrowLicenseOutput = struct {
    /// Information about constraints.
    checkout_metadata: ?[]const Metadata = null,

    /// Allowed license entitlements.
    entitlements_allowed: ?[]const EntitlementData = null,

    /// Date and time at which the license checkout expires.
    expiration: ?[]const u8 = null,

    /// Date and time at which the license checkout is issued.
    issued_at: ?[]const u8 = null,

    /// Amazon Resource Name (ARN) of the license.
    license_arn: ?[]const u8 = null,

    /// License consumption token.
    license_consumption_token: ?[]const u8 = null,

    /// Node ID.
    node_id: ?[]const u8 = null,

    /// Signed token.
    signed_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .checkout_metadata = "CheckoutMetadata",
        .entitlements_allowed = "EntitlementsAllowed",
        .expiration = "Expiration",
        .issued_at = "IssuedAt",
        .license_arn = "LicenseArn",
        .license_consumption_token = "LicenseConsumptionToken",
        .node_id = "NodeId",
        .signed_token = "SignedToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CheckoutBorrowLicenseInput, options: CallOptions) !CheckoutBorrowLicenseOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CheckoutBorrowLicenseInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSLicenseManager.CheckoutBorrowLicense");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CheckoutBorrowLicenseOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CheckoutBorrowLicenseOutput, body, allocator);
}
