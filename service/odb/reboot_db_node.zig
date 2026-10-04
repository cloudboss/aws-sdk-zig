const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DbNodeResourceStatus = @import("db_node_resource_status.zig").DbNodeResourceStatus;

pub const RebootDbNodeInput = struct {
    /// The unique identifier of the VM cluster that contains the DB node to reboot.
    cloud_vm_cluster_id: []const u8,

    /// The unique identifier of the DB node to reboot.
    db_node_id: []const u8,

    pub const json_field_names = .{
        .cloud_vm_cluster_id = "cloudVmClusterId",
        .db_node_id = "dbNodeId",
    };
};

pub const RebootDbNodeOutput = struct {
    /// The unique identifier of the DB node that was rebooted.
    db_node_id: []const u8,

    /// The current status of the DB node after the reboot operation.
    status: ?DbNodeResourceStatus = null,

    /// Additional information about the status of the DB node after the reboot
    /// operation.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .db_node_id = "dbNodeId",
        .status = "status",
        .status_reason = "statusReason",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RebootDbNodeInput, options: CallOptions) !RebootDbNodeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RebootDbNodeInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Odb.RebootDbNode");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RebootDbNodeOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(RebootDbNodeOutput, body, allocator);
}
