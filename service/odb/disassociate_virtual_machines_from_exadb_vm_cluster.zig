const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

pub const DisassociateVirtualMachinesFromExadbVmClusterInput = struct {
    /// The list of DB node IDs to remove from the Exascale VM cluster.
    db_node_ids: []const []const u8,

    /// The unique identifier of the Exascale VM cluster to remove virtual machines
    /// from.
    exadb_vm_cluster_id: []const u8,

    pub const json_field_names = .{
        .db_node_ids = "dbNodeIds",
        .exadb_vm_cluster_id = "exadbVmClusterId",
    };
};

pub const DisassociateVirtualMachinesFromExadbVmClusterOutput = struct {
    /// The user-friendly name for the Exascale VM cluster.
    display_name: ?[]const u8 = null,

    /// The unique identifier of the Exascale VM cluster.
    exadb_vm_cluster_id: []const u8,

    /// The current status of the Exascale VM cluster.
    status: ?ResourceStatus = null,

    /// Additional information about the status of the Exascale VM cluster.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .display_name = "displayName",
        .exadb_vm_cluster_id = "exadbVmClusterId",
        .status = "status",
        .status_reason = "statusReason",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DisassociateVirtualMachinesFromExadbVmClusterInput, options: CallOptions) !DisassociateVirtualMachinesFromExadbVmClusterOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DisassociateVirtualMachinesFromExadbVmClusterInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Odb.DisassociateVirtualMachinesFromExadbVmCluster");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DisassociateVirtualMachinesFromExadbVmClusterOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DisassociateVirtualMachinesFromExadbVmClusterOutput, body, allocator);
}
