const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ContainerGroupDefinition = @import("container_group_definition.zig").ContainerGroupDefinition;

pub const DescribeContainerGroupDefinitionInput = struct {
    /// The unique identifier for the container group definition to retrieve
    /// properties for. You can use either the `Name` or
    /// `ARN` value.
    name: []const u8,

    /// The specific version to retrieve.
    version_number: ?i32 = null,

    pub const json_field_names = .{
        .name = "Name",
        .version_number = "VersionNumber",
    };
};

pub const DescribeContainerGroupDefinitionOutput = struct {
    /// The properties of the requested container group definition resource.
    container_group_definition: ?ContainerGroupDefinition = null,

    pub const json_field_names = .{
        .container_group_definition = "ContainerGroupDefinition",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeContainerGroupDefinitionInput, options: CallOptions) !DescribeContainerGroupDefinitionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "gamelift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeContainerGroupDefinitionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("gamelift", "GameLift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.DescribeContainerGroupDefinition");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeContainerGroupDefinitionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeContainerGroupDefinitionOutput, body, allocator);
}
