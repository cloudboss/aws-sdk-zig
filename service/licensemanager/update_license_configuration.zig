const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LicenseConfigurationStatus = @import("license_configuration_status.zig").LicenseConfigurationStatus;
const ProductInformation = @import("product_information.zig").ProductInformation;

pub const UpdateLicenseConfigurationInput = struct {
    /// New description of the license configuration.
    description: ?[]const u8 = null,

    /// When true, disassociates a resource when software is uninstalled.
    disassociate_when_not_found: ?bool = null,

    /// Amazon Resource Name (ARN) of the license configuration.
    license_configuration_arn: []const u8,

    /// New status of the license configuration.
    license_configuration_status: ?LicenseConfigurationStatus = null,

    /// New number of licenses managed by the license configuration.
    license_count: ?i64 = null,

    /// New hard limit of the number of available licenses.
    license_count_hard_limit: ?bool = null,

    /// License configuration expiry time.
    license_expiry: ?i64 = null,

    /// New license rule. The only rule that you can add after you create a license
    /// configuration is licenseAffinityToHost.
    license_rules: ?[]const []const u8 = null,

    /// New name of the license configuration.
    name: ?[]const u8 = null,

    /// New product information.
    product_information_list: ?[]const ProductInformation = null,

    pub const json_field_names = .{
        .description = "Description",
        .disassociate_when_not_found = "DisassociateWhenNotFound",
        .license_configuration_arn = "LicenseConfigurationArn",
        .license_configuration_status = "LicenseConfigurationStatus",
        .license_count = "LicenseCount",
        .license_count_hard_limit = "LicenseCountHardLimit",
        .license_expiry = "LicenseExpiry",
        .license_rules = "LicenseRules",
        .name = "Name",
        .product_information_list = "ProductInformationList",
    };
};

pub const UpdateLicenseConfigurationOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateLicenseConfigurationInput, options: CallOptions) !UpdateLicenseConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateLicenseConfigurationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSLicenseManager.UpdateLicenseConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateLicenseConfigurationOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
