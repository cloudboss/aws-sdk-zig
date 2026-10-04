const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AppInstanceUserEndpoint = @import("app_instance_user_endpoint.zig").AppInstanceUserEndpoint;

pub const DescribeAppInstanceUserEndpointInput = struct {
    /// The ARN of the `AppInstanceUser`.
    app_instance_user_arn: []const u8,

    /// The unique identifier of the `AppInstanceUserEndpoint`.
    endpoint_id: []const u8,

    pub const json_field_names = .{
        .app_instance_user_arn = "AppInstanceUserArn",
        .endpoint_id = "EndpointId",
    };
};

pub const DescribeAppInstanceUserEndpointOutput = struct {
    /// The full details of an `AppInstanceUserEndpoint`: the `AppInstanceUserArn`,
    /// ID, name, type, resource ARN, attributes,
    /// allow messages, state, and created and last updated timestamps. All
    /// timestamps use epoch milliseconds.
    app_instance_user_endpoint: ?AppInstanceUserEndpoint = null,

    pub const json_field_names = .{
        .app_instance_user_endpoint = "AppInstanceUserEndpoint",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAppInstanceUserEndpointInput, options: CallOptions) !DescribeAppInstanceUserEndpointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "chime", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAppInstanceUserEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("identity-chime", "Chime SDK Identity", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/app-instance-users/");
    try path_buf.appendSlice(allocator, input.app_instance_user_arn);
    try path_buf.appendSlice(allocator, "/endpoints/");
    try path_buf.appendSlice(allocator, input.endpoint_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAppInstanceUserEndpointOutput {
    const result: DescribeAppInstanceUserEndpointOutput = try aws.json.parseJsonObject(
        DescribeAppInstanceUserEndpointOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
