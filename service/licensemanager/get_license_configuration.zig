const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutomatedDiscoveryInformation = @import("automated_discovery_information.zig").AutomatedDiscoveryInformation;
const ConsumedLicenseSummary = @import("consumed_license_summary.zig").ConsumedLicenseSummary;
const LicenseCountingType = @import("license_counting_type.zig").LicenseCountingType;
const ManagedResourceSummary = @import("managed_resource_summary.zig").ManagedResourceSummary;
const ProductInformation = @import("product_information.zig").ProductInformation;
const Tag = @import("tag.zig").Tag;

pub const GetLicenseConfigurationInput = struct {
    /// Amazon Resource Name (ARN) of the license configuration.
    license_configuration_arn: []const u8,

    pub const json_field_names = .{
        .license_configuration_arn = "LicenseConfigurationArn",
    };
};

pub const GetLicenseConfigurationOutput = struct {
    /// Automated discovery information.
    automated_discovery_information: ?AutomatedDiscoveryInformation = null,

    /// Number of licenses assigned to resources.
    consumed_licenses: ?i64 = null,

    /// Summaries of the licenses consumed by resources.
    consumed_license_summary_list: ?[]const ConsumedLicenseSummary = null,

    /// Description of the license configuration.
    description: ?[]const u8 = null,

    /// When true, disassociates a resource when software is uninstalled.
    disassociate_when_not_found: ?bool = null,

    /// Amazon Resource Name (ARN) of the license configuration.
    license_configuration_arn: ?[]const u8 = null,

    /// Unique ID for the license configuration.
    license_configuration_id: ?[]const u8 = null,

    /// Number of available licenses.
    license_count: ?i64 = null,

    /// Sets the number of available licenses as a hard limit.
    license_count_hard_limit: ?bool = null,

    /// Dimension for which the licenses are counted.
    license_counting_type: ?LicenseCountingType = null,

    /// License Expiry.
    license_expiry: ?i64 = null,

    /// License rules.
    license_rules: ?[]const []const u8 = null,

    /// Summaries of the managed resources.
    managed_resource_summary_list: ?[]const ManagedResourceSummary = null,

    /// Name of the license configuration.
    name: ?[]const u8 = null,

    /// Account ID of the owner of the license configuration.
    owner_account_id: ?[]const u8 = null,

    /// Product information.
    product_information_list: ?[]const ProductInformation = null,

    /// License configuration status.
    status: ?[]const u8 = null,

    /// Tags for the license configuration.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .automated_discovery_information = "AutomatedDiscoveryInformation",
        .consumed_licenses = "ConsumedLicenses",
        .consumed_license_summary_list = "ConsumedLicenseSummaryList",
        .description = "Description",
        .disassociate_when_not_found = "DisassociateWhenNotFound",
        .license_configuration_arn = "LicenseConfigurationArn",
        .license_configuration_id = "LicenseConfigurationId",
        .license_count = "LicenseCount",
        .license_count_hard_limit = "LicenseCountHardLimit",
        .license_counting_type = "LicenseCountingType",
        .license_expiry = "LicenseExpiry",
        .license_rules = "LicenseRules",
        .managed_resource_summary_list = "ManagedResourceSummaryList",
        .name = "Name",
        .owner_account_id = "OwnerAccountId",
        .product_information_list = "ProductInformationList",
        .status = "Status",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetLicenseConfigurationInput, options: CallOptions) !GetLicenseConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetLicenseConfigurationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSLicenseManager.GetLicenseConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetLicenseConfigurationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetLicenseConfigurationOutput, body, allocator);
}
