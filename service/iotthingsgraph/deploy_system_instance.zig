const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SystemInstanceSummary = @import("system_instance_summary.zig").SystemInstanceSummary;

pub const DeploySystemInstanceInput = struct {
    /// The ID of the system instance. This value is returned by the
    /// `CreateSystemInstance` action.
    ///
    /// The ID should be in the following format.
    ///
    /// `urn:tdm:REGION/ACCOUNT ID/default:deployment:DEPLOYMENTNAME`
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "id",
    };
};

pub const DeploySystemInstanceOutput = struct {
    /// The ID of the Greengrass deployment used to deploy the system instance.
    greengrass_deployment_id: ?[]const u8 = null,

    /// An object that contains summary information about a system instance that was
    /// deployed.
    summary: ?SystemInstanceSummary = null,

    pub const json_field_names = .{
        .greengrass_deployment_id = "greengrassDeploymentId",
        .summary = "summary",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeploySystemInstanceInput, options: CallOptions) !DeploySystemInstanceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotthingsgraph", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeploySystemInstanceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotthingsgraph", "IoTThingsGraph", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "IotThingsGraphFrontEndService.DeploySystemInstance");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeploySystemInstanceOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DeploySystemInstanceOutput, body, allocator);
}
