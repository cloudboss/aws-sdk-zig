const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OwnershipSettings = @import("ownership_settings.zig").OwnershipSettings;
const SpaceSettings = @import("space_settings.zig").SpaceSettings;
const SpaceSharingSettings = @import("space_sharing_settings.zig").SpaceSharingSettings;
const SpaceStatus = @import("space_status.zig").SpaceStatus;

pub const DescribeSpaceInput = struct {
    /// The ID of the associated domain.
    domain_id: []const u8,

    /// The name of the space.
    space_name: []const u8,

    pub const json_field_names = .{
        .domain_id = "DomainId",
        .space_name = "SpaceName",
    };
};

pub const DescribeSpaceOutput = struct {
    /// The creation time.
    creation_time: ?i64 = null,

    /// The ID of the associated domain.
    domain_id: ?[]const u8 = null,

    /// The failure reason.
    failure_reason: ?[]const u8 = null,

    /// The ID of the space's profile in the Amazon EFS volume.
    home_efs_file_system_uid: ?[]const u8 = null,

    /// The last modified time.
    last_modified_time: ?i64 = null,

    /// The collection of ownership settings for a space.
    ownership_settings: ?OwnershipSettings = null,

    /// The space's Amazon Resource Name (ARN).
    space_arn: ?[]const u8 = null,

    /// The name of the space that appears in the Amazon SageMaker Studio UI.
    space_display_name: ?[]const u8 = null,

    /// The name of the space.
    space_name: ?[]const u8 = null,

    /// A collection of space settings.
    space_settings: ?SpaceSettings = null,

    /// The collection of space sharing settings for a space.
    space_sharing_settings: ?SpaceSharingSettings = null,

    /// The status.
    status: ?SpaceStatus = null,

    /// Returns the URL of the space. If the space is created with Amazon Web
    /// Services IAM Identity Center (Successor to Amazon Web Services Single
    /// Sign-On) authentication, users can navigate to the URL after appending the
    /// respective redirect parameter for the application type to be federated
    /// through Amazon Web Services IAM Identity Center.
    ///
    /// The following application types are supported:
    ///
    /// * Studio Classic: `&redirect=JupyterServer`
    /// * JupyterLab: `&redirect=JupyterLab`
    /// * Code Editor, based on Code-OSS, Visual Studio Code - Open Source:
    ///   `&redirect=CodeEditor`
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .domain_id = "DomainId",
        .failure_reason = "FailureReason",
        .home_efs_file_system_uid = "HomeEfsFileSystemUid",
        .last_modified_time = "LastModifiedTime",
        .ownership_settings = "OwnershipSettings",
        .space_arn = "SpaceArn",
        .space_display_name = "SpaceDisplayName",
        .space_name = "SpaceName",
        .space_settings = "SpaceSettings",
        .space_sharing_settings = "SpaceSharingSettings",
        .status = "Status",
        .url = "Url",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeSpaceInput, options: CallOptions) !DescribeSpaceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeSpaceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeSpace");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeSpaceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeSpaceOutput, body, allocator);
}
