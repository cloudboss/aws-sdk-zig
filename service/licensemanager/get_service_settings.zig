const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OrganizationConfiguration = @import("organization_configuration.zig").OrganizationConfiguration;
const ServiceStatus = @import("service_status.zig").ServiceStatus;

pub const GetServiceSettingsInput = struct {};

pub const GetServiceSettingsOutput = struct {
    /// Cross region discovery home region.
    cross_region_discovery_home_region: ?[]const u8 = null,

    /// Cross region discovery source regions.
    cross_region_discovery_source_regions: ?[]const []const u8 = null,

    /// Indicates whether cross-account discovery is enabled.
    enable_cross_accounts_discovery: ?bool = null,

    /// Amazon Resource Name (ARN) of the resource share. The License Manager
    /// management account
    /// provides member accounts with access to this share.
    license_manager_resource_share_arn: ?[]const u8 = null,

    /// Indicates whether Organizations is integrated with License Manager for
    /// cross-account discovery.
    organization_configuration: ?OrganizationConfiguration = null,

    /// Regional S3 bucket path for storing reports, license trail event data,
    /// discovery data,
    /// and so on.
    s3_bucket_arn: ?[]const u8 = null,

    /// Service status.
    service_status: ?ServiceStatus = null,

    /// SNS topic configured to receive notifications from License Manager.
    sns_topic_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .cross_region_discovery_home_region = "CrossRegionDiscoveryHomeRegion",
        .cross_region_discovery_source_regions = "CrossRegionDiscoverySourceRegions",
        .enable_cross_accounts_discovery = "EnableCrossAccountsDiscovery",
        .license_manager_resource_share_arn = "LicenseManagerResourceShareArn",
        .organization_configuration = "OrganizationConfiguration",
        .s3_bucket_arn = "S3BucketArn",
        .service_status = "ServiceStatus",
        .sns_topic_arn = "SnsTopicArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetServiceSettingsInput, options: CallOptions) !GetServiceSettingsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetServiceSettingsInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("license-manager", "License Manager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = "{}";

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSLicenseManager.GetServiceSettings");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetServiceSettingsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetServiceSettingsOutput, body, allocator);
}
