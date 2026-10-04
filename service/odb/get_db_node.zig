const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DbNode = @import("db_node.zig").DbNode;

pub const GetDbNodeInput = struct {
    /// The unique identifier of the VM cluster that contains the DB node. You must
    /// specify either this parameter or `exadbVmClusterId`.
    cloud_vm_cluster_id: ?[]const u8 = null,

    /// The unique identifier of the DB node to retrieve information about.
    db_node_id: []const u8,

    /// The unique identifier of the Exascale VM cluster that contains the DB node.
    /// You must specify either this parameter or `cloudVmClusterId`.
    exadb_vm_cluster_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .cloud_vm_cluster_id = "cloudVmClusterId",
        .db_node_id = "dbNodeId",
        .exadb_vm_cluster_id = "exadbVmClusterId",
    };
};

pub const GetDbNodeOutput = struct {
    db_node: ?DbNode = null,

    pub const json_field_names = .{
        .db_node = "dbNode",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDbNodeInput, options: CallOptions) !GetDbNodeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "odb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDbNodeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("odb", "odb", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "Odb.GetDbNode");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDbNodeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetDbNodeOutput, body, allocator);
}
