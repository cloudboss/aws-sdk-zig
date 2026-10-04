const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ComponentSummary = @import("component_summary.zig").ComponentSummary;

pub const ListComponentsInput = struct {
    /// The name of an environment for result list filtering. Proton returns
    /// components associated with the environment or attached to service instances
    /// running in it.
    environment_name: ?[]const u8 = null,

    /// The maximum number of components to list.
    max_results: ?i32 = null,

    /// A token that indicates the location of the next component in the array of
    /// components, after the list of components that was previously
    /// requested.
    next_token: ?[]const u8 = null,

    /// The name of a service instance for result list filtering. Proton returns the
    /// component attached to the service instance, if any.
    service_instance_name: ?[]const u8 = null,

    /// The name of a service for result list filtering. Proton returns components
    /// attached to service instances of the service.
    service_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .environment_name = "environmentName",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .service_instance_name = "serviceInstanceName",
        .service_name = "serviceName",
    };
};

pub const ListComponentsOutput = struct {
    /// An array of components with summary data.
    components: ?[]const ComponentSummary = null,

    /// A token that indicates the location of the next component in the array of
    /// components, after the current requested list of components.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .components = "components",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListComponentsInput, options: CallOptions) !ListComponentsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListComponentsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AwsProton20200720.ListComponents");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListComponentsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListComponentsOutput, body, allocator);
}
