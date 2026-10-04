const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImageComputeType = @import("image_compute_type.zig").ImageComputeType;
const ImageSourceIdentifier = @import("image_source_identifier.zig").ImageSourceIdentifier;
const OSVersion = @import("os_version.zig").OSVersion;
const Platform = @import("platform.zig").Platform;
const CustomImageProtocol = @import("custom_image_protocol.zig").CustomImageProtocol;
const Tag = @import("tag.zig").Tag;
const CustomWorkspaceImageImportState = @import("custom_workspace_image_import_state.zig").CustomWorkspaceImageImportState;

pub const ImportCustomWorkspaceImageInput = struct {
    /// The supported compute type for the WorkSpace image.
    compute_type: ImageComputeType,

    /// The description of the WorkSpace image.
    image_description: []const u8,

    /// The name of the WorkSpace image.
    image_name: []const u8,

    /// The options for image import source.
    image_source: ImageSourceIdentifier,

    /// The infrastructure configuration ARN that specifies how the WorkSpace image
    /// is built.
    infrastructure_configuration_arn: []const u8,

    /// The OS version for the WorkSpace image source.
    os_version: OSVersion,

    /// The platform for the WorkSpace image source.
    platform: Platform,

    /// The supported protocol for the WorkSpace image. Windows 11 does not support
    /// PCOIP protocol.
    protocol: CustomImageProtocol,

    /// The resource tags. Each WorkSpaces resource can have a maximum of 50 tags.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .compute_type = "ComputeType",
        .image_description = "ImageDescription",
        .image_name = "ImageName",
        .image_source = "ImageSource",
        .infrastructure_configuration_arn = "InfrastructureConfigurationArn",
        .os_version = "OsVersion",
        .platform = "Platform",
        .protocol = "Protocol",
        .tags = "Tags",
    };
};

pub const ImportCustomWorkspaceImageOutput = struct {
    /// The identifier of the WorkSpace image.
    image_id: ?[]const u8 = null,

    /// The state of the WorkSpace image.
    state: ?CustomWorkspaceImageImportState = null,

    pub const json_field_names = .{
        .image_id = "ImageId",
        .state = "State",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportCustomWorkspaceImageInput, options: CallOptions) !ImportCustomWorkspaceImageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workspaces", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ImportCustomWorkspaceImageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workspaces", "WorkSpaces", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "WorkspacesService.ImportCustomWorkspaceImage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ImportCustomWorkspaceImageOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ImportCustomWorkspaceImageOutput, body, allocator);
}
