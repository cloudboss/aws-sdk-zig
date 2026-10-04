const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EnvironmentStatus = @import("environment_status.zig").EnvironmentStatus;

pub const DescribeEnvironmentStatusInput = struct {
    /// The ID of the environment to get status information about.
    environment_id: []const u8,

    pub const json_field_names = .{
        .environment_id = "environmentId",
    };
};

pub const DescribeEnvironmentStatusOutput = struct {
    /// Any informational message about the status of the environment.
    message: []const u8,

    /// The status of the environment. Available values include:
    ///
    /// * `connecting`: The environment is connecting.
    ///
    /// * `creating`: The environment is being created.
    ///
    /// * `deleting`: The environment is being deleted.
    ///
    /// * `error`: The environment is in an error state.
    ///
    /// * `ready`: The environment is ready.
    ///
    /// * `stopped`: The environment is stopped.
    ///
    /// * `stopping`: The environment is stopping.
    status: EnvironmentStatus,

    pub const json_field_names = .{
        .message = "message",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEnvironmentStatusInput, options: CallOptions) !DescribeEnvironmentStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloud9", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEnvironmentStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloud9", "Cloud9", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSCloud9WorkspaceManagementService.DescribeEnvironmentStatus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEnvironmentStatusOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeEnvironmentStatusOutput, body, allocator);
}
