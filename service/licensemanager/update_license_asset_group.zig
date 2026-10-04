const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LicenseAssetGroupConfiguration = @import("license_asset_group_configuration.zig").LicenseAssetGroupConfiguration;
const LicenseAssetGroupProperty = @import("license_asset_group_property.zig").LicenseAssetGroupProperty;
const LicenseAssetGroupStatus = @import("license_asset_group_status.zig").LicenseAssetGroupStatus;

pub const UpdateLicenseAssetGroupInput = struct {
    /// ARNs of associated license asset rulesets.
    associated_license_asset_ruleset_ar_ns: []const []const u8,

    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request.
    client_token: []const u8,

    /// License asset group description.
    description: ?[]const u8 = null,

    /// Amazon Resource Name (ARN) of the license asset group.
    license_asset_group_arn: []const u8,

    /// License asset group configurations.
    license_asset_group_configurations: ?[]const LicenseAssetGroupConfiguration = null,

    /// License asset group name.
    name: ?[]const u8 = null,

    /// License asset group properties.
    properties: ?[]const LicenseAssetGroupProperty = null,

    /// License asset group status. The possible values are `ACTIVE` | `DISABLED`.
    status: ?LicenseAssetGroupStatus = null,

    pub const json_field_names = .{
        .associated_license_asset_ruleset_ar_ns = "AssociatedLicenseAssetRulesetARNs",
        .client_token = "ClientToken",
        .description = "Description",
        .license_asset_group_arn = "LicenseAssetGroupArn",
        .license_asset_group_configurations = "LicenseAssetGroupConfigurations",
        .name = "Name",
        .properties = "Properties",
        .status = "Status",
    };
};

pub const UpdateLicenseAssetGroupOutput = struct {
    /// Amazon Resource Name (ARN) of the license asset group.
    license_asset_group_arn: []const u8,

    /// License asset group status.
    status: []const u8,

    pub const json_field_names = .{
        .license_asset_group_arn = "LicenseAssetGroupArn",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateLicenseAssetGroupInput, options: CallOptions) !UpdateLicenseAssetGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateLicenseAssetGroupInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSLicenseManager.UpdateLicenseAssetGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateLicenseAssetGroupOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateLicenseAssetGroupOutput, body, allocator);
}
