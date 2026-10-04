const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ListDeploymentConfigsInput = struct {
    /// An identifier returned from the previous `ListDeploymentConfigs` call. It
    /// can be used to return the next set of deployment configurations in the list.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
    };
};

pub const ListDeploymentConfigsOutput = struct {
    /// A list of deployment configurations, including built-in configurations such
    /// as
    /// `CodeDeployDefault.OneAtATime`.
    deployment_configs_list: ?[]const []const u8 = null,

    /// If a large amount of information is returned, an identifier is also
    /// returned. It can
    /// be used in a subsequent list deployment configurations call to return the
    /// next set of
    /// deployment configurations in the list.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .deployment_configs_list = "deploymentConfigsList",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDeploymentConfigsInput, options: CallOptions) !ListDeploymentConfigsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codedeploy", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDeploymentConfigsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codedeploy", "CodeDeploy", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodeDeploy_20141006.ListDeploymentConfigs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDeploymentConfigsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListDeploymentConfigsOutput, body, allocator);
}
