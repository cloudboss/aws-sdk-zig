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
    /// A string of up to 64 ASCII characters that Amazon EFS uses to ensure
    /// idempotent
    /// creation.
    client_token: []const u8,

    /// The ID of the EFS file system that the access point provides access to.
    file_system_id: []const u8,

    /// The operating system user and
    /// group applied to all file system requests made using the access point.
    posix_user: ?PosixUser = null,

    /// Specifies the directory on the EFS file system that the access point exposes
    /// as
    /// the root directory of your file system to NFS clients using the access
    /// point. The clients
    /// using the access point can only access the root directory and below. If the
    /// `RootDirectory` > `Path` specified does not exist, Amazon EFS creates it and
    /// applies the `CreationInfo` settings when a client connects to an
    /// access point. When specifying a `RootDirectory`, you must provide the
    /// `Path`, and the `CreationInfo`.
    ///
    /// Amazon EFS creates a root directory only if you have provided the
    /// CreationInfo: OwnUid, OwnGID, and permissions for the directory.
    /// If you do not provide this information, Amazon EFS does not create the root
    /// directory. If the root directory does not exist, attempts to mount
    /// using the access point will fail.
    root_directory: ?RootDirectory = null,

    /// Creates tags associated with the access point. Each tag is a key-value pair,
    /// each key must be unique. For more
    /// information, see [Tagging Amazon Web Services
    /// resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    /// in the *Amazon Web Services General Reference Guide*.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .file_system_id = "FileSystemId",
        .posix_user = "PosixUser",
        .root_directory = "RootDirectory",
        .tags = "Tags",
    };
};

pub const CreateAccessPointOutput = @import("access_point_description.zig").AccessPointDescription;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAccessPointInput, options: CallOptions) !CreateAccessPointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticfilesystem", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("elasticfilesystem", "EFS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2015-02-01/access-points";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ClientToken\":");
    try aws.json.writeValue(@TypeOf(input.client_token), input.client_token, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"FileSystemId\":");
    try aws.json.writeValue(@TypeOf(input.file_system_id), input.file_system_id, allocator, &body_buf);
    has_prev = true;
    if (input.posix_user) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PosixUser\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.root_directory) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RootDirectory\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
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
