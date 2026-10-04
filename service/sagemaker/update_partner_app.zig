const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PartnerAppConfig = @import("partner_app_config.zig").PartnerAppConfig;
const PartnerAppAuthType = @import("partner_app_auth_type.zig").PartnerAppAuthType;
const IdcConfigInput = @import("idc_config_input.zig").IdcConfigInput;
const PartnerAppMaintenanceConfig = @import("partner_app_maintenance_config.zig").PartnerAppMaintenanceConfig;
const Tag = @import("tag.zig").Tag;

pub const UpdatePartnerAppInput = struct {
    /// Configuration settings for the SageMaker Partner AI App.
    application_config: ?PartnerAppConfig = null,

    /// The semantic version to upgrade the SageMaker Partner AI App to. Must be the
    /// same semantic version returned in the `AvailableUpgrade` field from
    /// `DescribePartnerApp`. Version skipping and downgrades are not supported.
    app_version: ?[]const u8 = null,

    /// The ARN of the SageMaker Partner AI App to update.
    arn: []const u8,

    /// The authorization type that users use to access the SageMaker Partner AI
    /// App. Use this parameter to migrate an existing SageMaker Partner AI App from
    /// `IAM` authorization to `IDC` authorization. Valid values:
    ///
    /// * `IAM`: Users access the SageMaker Partner AI App with their Amazon Web
    ///   Services IAM identity.
    /// * `IDC`: Users access the SageMaker Partner AI App with their Amazon Web
    ///   Services IAM Identity Center identity. Specify the Identity Center
    ///   instance to use in `IdcConfig`.
    auth_type: ?PartnerAppAuthType = null,

    /// A unique token that guarantees that the call to this API is idempotent.
    client_token: ?[]const u8 = null,

    /// When set to `TRUE`, the SageMaker Partner AI App is automatically upgraded
    /// to the latest minor version during the next scheduled maintenance window, if
    /// one is available.
    enable_auto_minor_version_upgrade: ?bool = null,

    /// When set to `TRUE`, the SageMaker Partner AI App sets the Amazon Web
    /// Services IAM session name or the authenticated IAM user as the identity of
    /// the SageMaker Partner AI App user.
    enable_iam_session_based_identity: ?bool = null,

    /// Specifies the Amazon Web Services IAM Identity Center configuration for the
    /// SageMaker Partner AI App. Specify this parameter when `AuthType` is `IDC`.
    /// Apps that use `IAM` authorization don't use this parameter.
    idc_config: ?IdcConfigInput = null,

    /// Maintenance configuration settings for the SageMaker Partner AI App.
    maintenance_config: ?PartnerAppMaintenanceConfig = null,

    /// Each tag consists of a key and an optional value. Tag keys must be unique
    /// per resource.
    tags: ?[]const Tag = null,

    /// Indicates the instance type and size of the cluster attached to the
    /// SageMaker Partner AI App.
    tier: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_config = "ApplicationConfig",
        .app_version = "AppVersion",
        .arn = "Arn",
        .auth_type = "AuthType",
        .client_token = "ClientToken",
        .enable_auto_minor_version_upgrade = "EnableAutoMinorVersionUpgrade",
        .enable_iam_session_based_identity = "EnableIamSessionBasedIdentity",
        .idc_config = "IdcConfig",
        .maintenance_config = "MaintenanceConfig",
        .tags = "Tags",
        .tier = "Tier",
    };
};

pub const UpdatePartnerAppOutput = struct {
    /// The ARN of the SageMaker Partner AI App that was updated.
    arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePartnerAppInput, options: CallOptions) !UpdatePartnerAppOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePartnerAppInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.UpdatePartnerApp");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePartnerAppOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdatePartnerAppOutput, body, allocator);
}
