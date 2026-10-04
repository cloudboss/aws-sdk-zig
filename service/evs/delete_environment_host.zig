const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EnvironmentSummary = @import("environment_summary.zig").EnvironmentSummary;
const Host = @import("host.zig").Host;

pub const DeleteEnvironmentHostInput = struct {
    /// This parameter is not used in Amazon EVS currently. If you supply input for
    /// this parameter, it will have no effect.
    ///
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the host deletion request. If you do not specify a client
    /// token, a randomly generated token is used for the request to ensure
    /// idempotency.
    client_token: ?[]const u8 = null,

    /// A unique ID for the host's environment.
    environment_id: []const u8,

    /// The DNS hostname associated with the host to be deleted.
    host_name: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .environment_id = "environmentId",
        .host_name = "hostName",
    };
};

pub const DeleteEnvironmentHostOutput = struct {
    /// A summary of the environment that the host was deleted from.
    environment_summary: ?EnvironmentSummary = null,

    /// A description of the deleted host.
    host: ?Host = null,

    pub const json_field_names = .{
        .environment_summary = "environmentSummary",
        .host = "host",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteEnvironmentHostInput, options: CallOptions) !DeleteEnvironmentHostOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "evs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteEnvironmentHostInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("evs", "evs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonElasticVMwareService.DeleteEnvironmentHost");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteEnvironmentHostOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteEnvironmentHostOutput, body, allocator);
}
