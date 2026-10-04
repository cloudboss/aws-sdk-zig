const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DbNodeResourceStatus = @import("db_node_resource_status.zig").DbNodeResourceStatus;

pub const StopDbNodeInput = struct {
    /// The unique identifier of the VM cluster that contains the DB node to stop.
    /// You must specify either this parameter or `exadbVmClusterId`.
    cloud_vm_cluster_id: ?[]const u8 = null,

    /// The unique identifier of the DB node to stop.
    db_node_id: []const u8,

    /// The unique identifier of the Exascale VM cluster that contains the DB node
    /// to stop. You must specify either this parameter or `cloudVmClusterId`.
    exadb_vm_cluster_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .cloud_vm_cluster_id = "cloudVmClusterId",
        .db_node_id = "dbNodeId",
        .exadb_vm_cluster_id = "exadbVmClusterId",
    };
};

pub const StopDbNodeOutput = struct {
    /// The unique identifier of the DB node that was stopped.
    db_node_id: []const u8,

    /// The current status of the DB node after the stop operation.
    status: ?DbNodeResourceStatus = null,

    /// Additional information about the status of the DB node after the stop
    /// operation.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .db_node_id = "dbNodeId",
        .status = "status",
        .status_reason = "statusReason",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StopDbNodeInput, options: CallOptions) !StopDbNodeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StopDbNodeInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Odb.StopDbNode");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StopDbNodeOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(StopDbNodeOutput, body, allocator);
}
