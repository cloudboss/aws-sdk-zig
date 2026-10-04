const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Output = @import("output.zig").Output;

pub const ListComponentOutputsInput = struct {
    /// The name of the component whose outputs you want.
    component_name: []const u8,

    /// The ID of the deployment whose outputs you want.
    deployment_id: ?[]const u8 = null,

    /// A token that indicates the location of the next output in the array of
    /// outputs, after the list of outputs that was previously requested.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .component_name = "componentName",
        .deployment_id = "deploymentId",
        .next_token = "nextToken",
    };
};

pub const ListComponentOutputsOutput = struct {
    /// A token that indicates the location of the next output in the array of
    /// outputs, after the list of outputs that was previously requested.
    next_token: ?[]const u8 = null,

    /// An array of component Infrastructure as Code (IaC) outputs.
    outputs: ?[]const Output = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .outputs = "outputs",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListComponentOutputsInput, options: CallOptions) !ListComponentOutputsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListComponentOutputsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AwsProton20200720.ListComponentOutputs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListComponentOutputsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListComponentOutputsOutput, body, allocator);
}
