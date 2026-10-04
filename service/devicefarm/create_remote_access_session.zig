const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CreateRemoteAccessSessionConfiguration = @import("create_remote_access_session_configuration.zig").CreateRemoteAccessSessionConfiguration;
const InteractionMode = @import("interaction_mode.zig").InteractionMode;
const RemoteAccessSession = @import("remote_access_session.zig").RemoteAccessSession;

pub const CreateRemoteAccessSessionInput = struct {
    /// The Amazon Resource Name (ARN) of the app to create the remote access
    /// session.
    app_arn: ?[]const u8 = null,

    /// The configuration information for the remote access session request.
    configuration: ?CreateRemoteAccessSessionConfiguration = null,

    /// The ARN of the device for which you want to create a remote access session.
    device_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the device instance for which you want to
    /// create a
    /// remote access session.
    instance_arn: ?[]const u8 = null,

    /// The interaction mode of the remote access session. Changing the interactive
    /// mode of remote access sessions is no longer available.
    interaction_mode: ?InteractionMode = null,

    /// The name of the remote access session to create.
    name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the project for which you want to create a
    /// remote
    /// access session.
    project_arn: []const u8,

    /// When set to `true`, for private devices, Device Farm does not sign your app
    /// again. For public
    /// devices, Device Farm always signs your apps again.
    ///
    /// For more information on how Device Farm modifies your uploads during tests,
    /// see [Do you modify my app?](http://aws.amazon.com/device-farm/faqs/)
    skip_app_resign: ?bool = null,

    pub const json_field_names = .{
        .app_arn = "appArn",
        .configuration = "configuration",
        .device_arn = "deviceArn",
        .instance_arn = "instanceArn",
        .interaction_mode = "interactionMode",
        .name = "name",
        .project_arn = "projectArn",
        .skip_app_resign = "skipAppResign",
    };
};

pub const CreateRemoteAccessSessionOutput = struct {
    /// A container that describes the remote access session when the request to
    /// create a
    /// remote access session is sent.
    remote_access_session: ?RemoteAccessSession = null,

    pub const json_field_names = .{
        .remote_access_session = "remoteAccessSession",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRemoteAccessSessionInput, options: CallOptions) !CreateRemoteAccessSessionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "devicefarm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRemoteAccessSessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("devicefarm", "Device Farm", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "DeviceFarm_20150623.CreateRemoteAccessSession");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRemoteAccessSessionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateRemoteAccessSessionOutput, body, allocator);
}
