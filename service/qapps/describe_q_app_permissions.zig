const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PermissionOutput = @import("permission_output.zig").PermissionOutput;

pub const DescribeQAppPermissionsInput = struct {
    /// The unique identifier of the Amazon Q App for which to retrieve permissions.
    app_id: []const u8,

    /// The unique identifier of the Amazon Q Business application environment
    /// instance.
    instance_id: []const u8,

    pub const json_field_names = .{
        .app_id = "appId",
        .instance_id = "instanceId",
    };
};

pub const DescribeQAppPermissionsOutput = struct {
    /// The unique identifier of the Amazon Q App for which permissions are
    /// returned.
    app_id: ?[]const u8 = null,

    /// The list of permissions granted for the Amazon Q App.
    permissions: ?[]const PermissionOutput = null,

    /// The Amazon Resource Name (ARN) of the Amazon Q App for which permissions are
    /// returned.
    resource_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_id = "appId",
        .permissions = "permissions",
        .resource_arn = "resourceArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeQAppPermissionsInput, options: CallOptions) !DescribeQAppPermissionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "qapps", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeQAppPermissionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("data.qapps", "QApps", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/apps.describeQAppPermissions";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "appId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.app_id);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");
    try request.headers.put(allocator, "instance-id", input.instance_id);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeQAppPermissionsOutput {
    const result: DescribeQAppPermissionsOutput = try aws.json.parseJsonObject(
        DescribeQAppPermissionsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
