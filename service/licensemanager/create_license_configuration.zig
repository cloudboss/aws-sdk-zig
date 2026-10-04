const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LicenseCountingType = @import("license_counting_type.zig").LicenseCountingType;
const ProductInformation = @import("product_information.zig").ProductInformation;
const Tag = @import("tag.zig").Tag;

pub const CreateLicenseConfigurationInput = struct {
    /// Description of the license configuration.
    description: ?[]const u8 = null,

    /// When true, disassociates a resource when software is uninstalled.
    disassociate_when_not_found: ?bool = null,

    /// Number of licenses managed by the license configuration.
    license_count: ?i64 = null,

    /// Indicates whether hard or soft license enforcement is used. Exceeding a hard
    /// limit
    /// blocks the launch of new instances.
    license_count_hard_limit: ?bool = null,

    /// Dimension used to track the license inventory.
    license_counting_type: LicenseCountingType,

    /// License configuration expiry.
    license_expiry: ?i64 = null,

    /// License rules. The syntax is #name=value (for example,
    /// #allowedTenancy=EC2-DedicatedHost). The available rules
    /// vary by dimension, as follows.
    ///
    /// * `Cores` dimension: `allowedTenancy` |
    /// `licenseAffinityToHost` |
    /// `maximumCores` | `minimumCores`
    ///
    /// * `Instances` dimension: `allowedTenancy` |
    /// `maximumVcpus` | `minimumVcpus`
    ///
    /// * `Sockets` dimension: `allowedTenancy` |
    /// `licenseAffinityToHost` |
    /// `maximumSockets` | `minimumSockets`
    ///
    /// * `vCPUs` dimension: `allowedTenancy` |
    /// `honorVcpuOptimization` |
    /// `maximumVcpus` | `minimumVcpus`
    ///
    /// The unit for `licenseAffinityToHost` is days and the range is 1 to 180. The
    /// possible
    /// values for `allowedTenancy` are `EC2-Default`, `EC2-DedicatedHost`, and
    /// `EC2-DedicatedInstance`. The possible values for `honorVcpuOptimization` are
    /// `True` and `False`.
    license_rules: ?[]const []const u8 = null,

    /// Name of the license configuration.
    name: []const u8,

    /// Product information.
    product_information_list: ?[]const ProductInformation = null,

    /// Tags to add to the license configuration.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .description = "Description",
        .disassociate_when_not_found = "DisassociateWhenNotFound",
        .license_count = "LicenseCount",
        .license_count_hard_limit = "LicenseCountHardLimit",
        .license_counting_type = "LicenseCountingType",
        .license_expiry = "LicenseExpiry",
        .license_rules = "LicenseRules",
        .name = "Name",
        .product_information_list = "ProductInformationList",
        .tags = "Tags",
    };
};

pub const CreateLicenseConfigurationOutput = struct {
    /// Amazon Resource Name (ARN) of the license configuration.
    license_configuration_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .license_configuration_arn = "LicenseConfigurationArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLicenseConfigurationInput, options: CallOptions) !CreateLicenseConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateLicenseConfigurationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSLicenseManager.CreateLicenseConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateLicenseConfigurationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateLicenseConfigurationOutput, body, allocator);
}
