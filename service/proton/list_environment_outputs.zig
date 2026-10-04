const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Output = @import("output.zig").Output;

pub const ListEnvironmentOutputsInput = struct {
    /// The ID of the deployment whose outputs you want.
    deployment_id: ?[]const u8 = null,

    /// The environment name.
    environment_name: []const u8,

    /// A token that indicates the location of the next environment output in the
    /// array of environment outputs, after the list of environment outputs that was
    /// previously requested.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .deployment_id = "deploymentId",
        .environment_name = "environmentName",
        .next_token = "nextToken",
    };
};

pub const ListEnvironmentOutputsOutput = struct {
    /// A token that indicates the location of the next environment output in the
    /// array of environment outputs, after the current requested list of
    /// environment outputs.
    next_token: ?[]const u8 = null,

    /// An array of environment outputs with detail data.
    outputs: ?[]const Output = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .outputs = "outputs",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEnvironmentOutputsInput, options: CallOptions) !ListEnvironmentOutputsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsproton20200720", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListEnvironmentOutputsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("proton", "Proton", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AwsProton20200720.ListEnvironmentOutputs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEnvironmentOutputsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListEnvironmentOutputsOutput, body, allocator);
}
