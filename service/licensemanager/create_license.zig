const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConsumptionConfiguration = @import("consumption_configuration.zig").ConsumptionConfiguration;
const Entitlement = @import("entitlement.zig").Entitlement;
const Issuer = @import("issuer.zig").Issuer;
const Metadata = @import("metadata.zig").Metadata;
const Tag = @import("tag.zig").Tag;
const DatetimeRange = @import("datetime_range.zig").DatetimeRange;
const LicenseStatus = @import("license_status.zig").LicenseStatus;

pub const CreateLicenseInput = struct {
    /// License beneficiary.
    beneficiary: []const u8,

    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request.
    client_token: []const u8,

    /// Configuration for consumption of the license. Choose a provisional
    /// configuration for workloads
    /// running with continuous connectivity. Choose a borrow configuration for
    /// workloads with offline
    /// usage.
    consumption_configuration: ConsumptionConfiguration,

    /// License entitlements.
    entitlements: []const Entitlement,

    /// Home Region for the license.
    home_region: []const u8,

    /// License issuer.
    issuer: Issuer,

    /// Information about the license.
    license_metadata: ?[]const Metadata = null,

    /// License name.
    license_name: []const u8,

    /// Product name.
    product_name: []const u8,

    /// Product SKU.
    product_sku: []const u8,

    /// Tags to add to the license. For more information about tagging support in
    /// License Manager, see the
    /// [TagResource](https://docs.aws.amazon.com/license-manager/latest/APIReference/API_TagResource.html) operation.
    tags: ?[]const Tag = null,

    /// Date and time range during which the license is valid, in ISO8601-UTC
    /// format.
    validity: DatetimeRange,

    pub const json_field_names = .{
        .beneficiary = "Beneficiary",
        .client_token = "ClientToken",
        .consumption_configuration = "ConsumptionConfiguration",
        .entitlements = "Entitlements",
        .home_region = "HomeRegion",
        .issuer = "Issuer",
        .license_metadata = "LicenseMetadata",
        .license_name = "LicenseName",
        .product_name = "ProductName",
        .product_sku = "ProductSKU",
        .tags = "Tags",
        .validity = "Validity",
    };
};

pub const CreateLicenseOutput = struct {
    /// Amazon Resource Name (ARN) of the license.
    license_arn: ?[]const u8 = null,

    /// License status.
    status: ?LicenseStatus = null,

    /// License version.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .license_arn = "LicenseArn",
        .status = "Status",
        .version = "Version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLicenseInput, options: CallOptions) !CreateLicenseOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateLicenseInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSLicenseManager.CreateLicense");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateLicenseOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateLicenseOutput, body, allocator);
}
