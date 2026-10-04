const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConsumptionConfiguration = @import("consumption_configuration.zig").ConsumptionConfiguration;
const Entitlement = @import("entitlement.zig").Entitlement;
const Issuer = @import("issuer.zig").Issuer;
const Metadata = @import("metadata.zig").Metadata;
const LicenseStatus = @import("license_status.zig").LicenseStatus;
const DatetimeRange = @import("datetime_range.zig").DatetimeRange;

pub const CreateLicenseVersionInput = struct {
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

    /// Home Region of the license.
    home_region: []const u8,

    /// License issuer.
    issuer: Issuer,

    /// Amazon Resource Name (ARN) of the license.
    license_arn: []const u8,

    /// Information about the license.
    license_metadata: ?[]const Metadata = null,

    /// License name.
    license_name: []const u8,

    /// Product name.
    product_name: []const u8,

    /// Current version of the license.
    source_version: ?[]const u8 = null,

    /// License status.
    status: LicenseStatus,

    /// Date and time range during which the license is valid, in ISO8601-UTC
    /// format.
    validity: DatetimeRange,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .consumption_configuration = "ConsumptionConfiguration",
        .entitlements = "Entitlements",
        .home_region = "HomeRegion",
        .issuer = "Issuer",
        .license_arn = "LicenseArn",
        .license_metadata = "LicenseMetadata",
        .license_name = "LicenseName",
        .product_name = "ProductName",
        .source_version = "SourceVersion",
        .status = "Status",
        .validity = "Validity",
    };
};

pub const CreateLicenseVersionOutput = struct {
    /// License ARN.
    license_arn: ?[]const u8 = null,

    /// License status.
    status: ?LicenseStatus = null,

    /// New version of the license.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .license_arn = "LicenseArn",
        .status = "Status",
        .version = "Version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLicenseVersionInput, options: CallOptions) !CreateLicenseVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateLicenseVersionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSLicenseManager.CreateLicenseVersion");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateLicenseVersionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateLicenseVersionOutput, body, allocator);
}
