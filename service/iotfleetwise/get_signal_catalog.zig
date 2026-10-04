const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NodeCounts = @import("node_counts.zig").NodeCounts;

pub const GetSignalCatalogInput = struct {
    /// The name of the signal catalog to retrieve information about.
    name: []const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};

pub const GetSignalCatalogOutput = struct {
    /// The Amazon Resource Name (ARN) of the signal catalog.
    arn: []const u8,

    /// The time the signal catalog was created in seconds since epoch (January 1,
    /// 1970 at midnight UTC time).
    creation_time: i64,

    /// A brief description of the signal catalog.
    description: ?[]const u8 = null,

    /// The last time the signal catalog was modified.
    last_modification_time: i64,

    /// The name of the signal catalog.
    name: []const u8,

    /// The total number of network nodes specified in a signal catalog.
    node_counts: ?NodeCounts = null,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .description = "description",
        .last_modification_time = "lastModificationTime",
        .name = "name",
        .node_counts = "nodeCounts",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSignalCatalogInput, options: CallOptions) !GetSignalCatalogOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSignalCatalogInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "IoTAutobahnControlPlane.GetSignalCatalog");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSignalCatalogOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetSignalCatalogOutput, body, allocator);
}
