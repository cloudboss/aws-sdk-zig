const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GroupVersion = @import("group_version.zig").GroupVersion;

pub const GetGroupVersionInput = struct {
    /// The ID of the Greengrass group.
    group_id: []const u8,

    /// The ID of the group version. This value maps to the ''Version'' property of
    /// the corresponding ''VersionInformation'' object, which is returned by
    /// ''ListGroupVersions'' requests. If the version is the last one that was
    /// associated with a group, the value also maps to the ''LatestVersion''
    /// property of the corresponding ''GroupInformation'' object.
    group_version_id: []const u8,

    pub const json_field_names = .{
        .group_id = "GroupId",
        .group_version_id = "GroupVersionId",
    };
};

pub const GetGroupVersionOutput = struct {
    /// The ARN of the group version.
    arn: ?[]const u8 = null,

    /// The time, in milliseconds since the epoch, when the group version was
    /// created.
    creation_timestamp: ?[]const u8 = null,

    /// Information about the group version definition.
    definition: ?GroupVersion = null,

    /// The ID of the group that the version is associated with.
    id: ?[]const u8 = null,

    /// The ID of the group version.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_timestamp = "CreationTimestamp",
        .definition = "Definition",
        .id = "Id",
        .version = "Version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetGroupVersionInput, options: CallOptions) !GetGroupVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "greengrass", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetGroupVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("greengrass", "Greengrass", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/greengrass/groups/");
    try path_buf.appendSlice(allocator, input.group_id);
    try path_buf.appendSlice(allocator, "/versions/");
    try path_buf.appendSlice(allocator, input.group_version_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetGroupVersionOutput {
    const result: GetGroupVersionOutput = try aws.json.parseJsonObject(
        GetGroupVersionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
