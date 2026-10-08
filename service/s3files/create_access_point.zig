const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PosixUser = @import("posix_user.zig").PosixUser;
const RootDirectory = @import("root_directory.zig").RootDirectory;
const Tag = @import("tag.zig").Tag;
const LifeCycleState = @import("life_cycle_state.zig").LifeCycleState;

pub const CreateAccessPointInput = struct {
    /// A unique, case-sensitive identifier to ensure that the operation completes
    /// no more than one time. If this token matches a previous request, Amazon Web
    /// Services ignores the request, but does not return an error.
    client_token: ?[]const u8 = null,

    /// The ID or Amazon Resource Name (ARN) of the S3 File System.
    file_system_id: []const u8,

    /// The POSIX identity with uid, gid, and secondary group IDs for user
    /// enforcement when accessing the file system through this access point.
    posix_user: ?PosixUser = null,

    /// The root directory path for the access point, with optional creation
    /// permissions for newly created directories.
    root_directory: ?RootDirectory = null,

    /// An array of key-value pairs to apply to the access point for resource
    /// tagging.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .file_system_id = "fileSystemId",
        .posix_user = "posixUser",
        .root_directory = "rootDirectory",
        .tags = "tags",
    };
};

pub const CreateAccessPointOutput = struct {
    /// The Amazon Resource Name (ARN) of the access point.
    access_point_arn: []const u8,

    /// The ID of the access point.
    access_point_id: []const u8,

    /// The client token that was provided in the request.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAccessPointInput, options: CallOptions) !CreateAccessPointOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAccessPointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3files", "S3Files", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/access-points";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"fileSystemId\":");
    try aws.json.writeValue(@TypeOf(input.file_system_id), input.file_system_id, allocator, &body_buf);
    has_prev = true;
    if (input.posix_user) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"posixUser\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.root_directory) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"rootDirectory\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAccessPointOutput {
    const result: CreateAccessPointOutput = try aws.json.parseJsonObject(
        CreateAccessPointOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
