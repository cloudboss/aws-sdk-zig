const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const View = @import("view.zig").View;

pub const DescribeViewInput = struct {
    /// The identifier of the Amazon Connect instance. You can find the instanceId
    /// in the ARN of the
    /// instance.
    instance_id: []const u8,

    /// The ViewId of the view. This must be an ARN for Amazon Web Services managed
    /// views.
    view_id: []const u8,

    pub const json_field_names = .{
        .instance_id = "InstanceId",
        .view_id = "ViewId",
    };
};

pub const DescribeViewOutput = struct {
    /// All view data is contained within the View object.
    view: ?View = null,

    pub const json_field_names = .{
        .view = "View",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeViewInput, options: CallOptions) !DescribeViewOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeViewInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/views/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.view_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeViewOutput {
    var result: DescribeViewOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeViewOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
