const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Node = @import("node.zig").Node;

pub const UpdateSignalCatalogInput = struct {
    /// A brief description of the signal catalog to update.
    description: ?[]const u8 = null,

    /// The name of the signal catalog to update.
    name: []const u8,

    /// A list of information about nodes to add to the signal catalog.
    nodes_to_add: ?[]const Node = null,

    /// A list of `fullyQualifiedName` of nodes to remove from the signal catalog.
    nodes_to_remove: ?[]const []const u8 = null,

    /// A list of information about nodes to update in the signal catalog.
    nodes_to_update: ?[]const Node = null,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .nodes_to_add = "nodesToAdd",
        .nodes_to_remove = "nodesToRemove",
        .nodes_to_update = "nodesToUpdate",
    };
};

pub const UpdateSignalCatalogOutput = struct {
    /// The ARN of the updated signal catalog.
    arn: []const u8,

    /// The name of the updated signal catalog.
    name: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .name = "name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSignalCatalogInput, options: CallOptions) !UpdateSignalCatalogOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotfleetwise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSignalCatalogInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotfleetwise", "IoTFleetWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "IoTAutobahnControlPlane.UpdateSignalCatalog");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSignalCatalogOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateSignalCatalogOutput, body, allocator);
}
