const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccessEndpoint = @import("access_endpoint.zig").AccessEndpoint;
const AppBlockBuilderAttribute = @import("app_block_builder_attribute.zig").AppBlockBuilderAttribute;
const PlatformType = @import("platform_type.zig").PlatformType;
const VpcConfig = @import("vpc_config.zig").VpcConfig;
const AppBlockBuilder = @import("app_block_builder.zig").AppBlockBuilder;

pub const UpdateAppBlockBuilderInput = struct {
    /// The list of interface VPC endpoint (interface endpoint) objects.
    /// Administrators can connect to the app block builder only through the
    /// specified endpoints.
    access_endpoints: ?[]const AccessEndpoint = null,

    /// The attributes to delete from the app block builder.
    attributes_to_delete: ?[]const AppBlockBuilderAttribute = null,

    /// The description of the app block builder.
    description: ?[]const u8 = null,

    /// Set to true to disable Instance Metadata Service Version 1 (IMDSv1) and
    /// enforce IMDSv2. Set to false to enable both IMDSv1 and IMDSv2.
    disable_imdsv1: ?bool = null,

    /// The display name of the app block builder.
    display_name: ?[]const u8 = null,

    /// Enables or disables default internet access for the app block builder.
    enable_default_internet_access: ?bool = null,

    /// The Amazon Resource Name (ARN) of the IAM role to apply to the app block
    /// builder. To
    /// assume a role, the app block builder calls the AWS Security Token Service
    /// (STS)
    /// `AssumeRole` API operation and passes the ARN of the role to use. The
    /// operation creates a new session with temporary credentials. WorkSpaces
    /// Applications retrieves the
    /// temporary credentials and creates the **appstream_machine_role** credential
    /// profile on the instance.
    ///
    /// For more information, see [Using an IAM Role to Grant Permissions to
    /// Applications and Scripts Running on WorkSpaces Applications Streaming
    /// Instances](https://docs.aws.amazon.com/appstream2/latest/developerguide/using-iam-roles-to-grant-permissions-to-applications-scripts-streaming-instances.html) in the *Amazon WorkSpaces Applications Administration Guide*.
    iam_role_arn: ?[]const u8 = null,

    /// The instance type to use when launching the app block builder. The following
    /// instance
    /// types are available:
    ///
    /// * stream.standard.small
    ///
    /// * stream.standard.medium
    ///
    /// * stream.standard.large
    ///
    /// * stream.standard.xlarge
    ///
    /// * stream.standard.2xlarge
    instance_type: ?[]const u8 = null,

    /// The unique name for the app block builder.
    name: []const u8,

    /// The platform of the app block builder.
    ///
    /// `WINDOWS_SERVER_2019` is the only valid value.
    platform: ?PlatformType = null,

    /// The VPC configuration for the app block builder.
    ///
    /// App block builders require that you specify at least two subnets in
    /// different availability
    /// zones.
    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .access_endpoints = "AccessEndpoints",
        .attributes_to_delete = "AttributesToDelete",
        .description = "Description",
        .disable_imdsv1 = "DisableIMDSV1",
        .display_name = "DisplayName",
        .enable_default_internet_access = "EnableDefaultInternetAccess",
        .iam_role_arn = "IamRoleArn",
        .instance_type = "InstanceType",
        .name = "Name",
        .platform = "Platform",
        .vpc_config = "VpcConfig",
    };
};

pub const UpdateAppBlockBuilderOutput = struct {
    app_block_builder: ?AppBlockBuilder = null,

    pub const json_field_names = .{
        .app_block_builder = "AppBlockBuilder",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAppBlockBuilderInput, options: CallOptions) !UpdateAppBlockBuilderOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appstream", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAppBlockBuilderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appstream2", "AppStream", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "PhotonAdminProxyService.UpdateAppBlockBuilder");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAppBlockBuilderOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateAppBlockBuilderOutput, body, allocator);
}
