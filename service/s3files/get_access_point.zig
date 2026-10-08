const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PosixUser = @import("posix_user.zig").PosixUser;
const RootDirectory = @import("root_directory.zig").RootDirectory;
const LifeCycleState = @import("life_cycle_state.zig").LifeCycleState;
const Tag = @import("tag.zig").Tag;

pub const GetAccessPointInput = struct {
    /// The ID or Amazon Resource Name (ARN) of the access point to retrieve
    /// information for.
    access_point_id: []const u8,

    pub const json_field_names = .{
        .access_point_id = "accessPointId",
    };
};

pub const GetAccessPointOutput = struct {
    /// The ARN of the access point.
    access_point_arn: []const u8,

    /// The ID of the access point.
    access_point_id: []const u8,

    /// The client token used for idempotency when the access point was created.
    client_token: []const u8,

    /// The ID of the S3 File System.
    file_system_id: []const u8,

    /// The name of the access point.
    name: ?[]const u8 = null,

    /// The Amazon Web Services account ID of the access point owner.
    owner_id: []const u8,

    /// The POSIX identity configured for this access point.
    posix_user: ?PosixUser = null,

    /// The root directory configuration for this access point.
    root_directory: ?RootDirectory = null,

    /// The current status of the access point.
    status: LifeCycleState,

    /// The tags associated with the access point.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .access_point_arn = "accessPointArn",
        .access_point_id = "accessPointId",
        .client_token = "clientToken",
        .file_system_id = "fileSystemId",
        .name = "name",
        .owner_id = "ownerId",
        .posix_user = "posixUser",
        .root_directory = "rootDirectory",
        .status = "status",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAccessPointInput, options: CallOptions) !GetAccessPointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "s3files", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAccessPointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3files", "S3Files", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/access-points/");
    try path_buf.appendSlice(allocator, input.access_point_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAccessPointOutput {
    const result: GetAccessPointOutput = try aws.json.parseJsonObject(
        GetAccessPointOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
