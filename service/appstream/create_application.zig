const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const S3Location = @import("s3_location.zig").S3Location;
const PlatformType = @import("platform_type.zig").PlatformType;
const Application = @import("application.zig").Application;

pub const CreateApplicationInput = struct {
    /// The app block ARN to which the application should be associated
    app_block_arn: []const u8,

    /// The description of the application.
    description: ?[]const u8 = null,

    /// The display name of the application. This name is visible to users in the
    /// application catalog.
    display_name: ?[]const u8 = null,

    /// The location in S3 of the application icon.
    icon_s3_location: S3Location,

    /// The instance families the application supports. Valid values are
    /// GENERAL_PURPOSE and GRAPHICS_G4.
    instance_families: []const []const u8,

    /// The launch parameters of the application.
    launch_parameters: ?[]const u8 = null,

    /// The launch path of the application.
    launch_path: []const u8,

    /// The name of the application. This name is visible to users when display name
    /// is not specified.
    name: []const u8,

    /// The platforms the application supports. WINDOWS_SERVER_2019, AMAZON_LINUX2
    /// and UBUNTU_PRO_2404 are supported for Elastic fleets.
    platforms: []const PlatformType,

    /// The tags assigned to the application.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The working directory of the application.
    working_directory: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_block_arn = "AppBlockArn",
        .description = "Description",
        .display_name = "DisplayName",
        .icon_s3_location = "IconS3Location",
        .instance_families = "InstanceFamilies",
        .launch_parameters = "LaunchParameters",
        .launch_path = "LaunchPath",
        .name = "Name",
        .platforms = "Platforms",
        .tags = "Tags",
        .working_directory = "WorkingDirectory",
    };
};

pub const CreateApplicationOutput = struct {
    application: ?Application = null,

    pub const json_field_names = .{
        .application = "Application",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateApplicationInput, options: CallOptions) !CreateApplicationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateApplicationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PhotonAdminProxyService.CreateApplication");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateApplicationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateApplicationOutput, body, allocator);
}
