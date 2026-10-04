const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GlobalSecondaryIndexAutoScalingUpdate = @import("global_secondary_index_auto_scaling_update.zig").GlobalSecondaryIndexAutoScalingUpdate;
const AutoScalingSettingsUpdate = @import("auto_scaling_settings_update.zig").AutoScalingSettingsUpdate;
const ReplicaAutoScalingUpdate = @import("replica_auto_scaling_update.zig").ReplicaAutoScalingUpdate;
const TableAutoScalingDescription = @import("table_auto_scaling_description.zig").TableAutoScalingDescription;

pub const UpdateTableReplicaAutoScalingInput = struct {
    /// Represents the auto scaling settings of the global secondary indexes of the
    /// replica to
    /// be updated.
    global_secondary_index_updates: ?[]const GlobalSecondaryIndexAutoScalingUpdate = null,

    provisioned_write_capacity_auto_scaling_update: ?AutoScalingSettingsUpdate = null,

    /// Represents the auto scaling settings of replicas of the table that will be
    /// modified.
    replica_updates: ?[]const ReplicaAutoScalingUpdate = null,

    /// The name of the global table to be updated. You can also provide the Amazon
    /// Resource Name (ARN) of the
    /// table in this parameter.
    table_name: []const u8,

    pub const json_field_names = .{
        .global_secondary_index_updates = "GlobalSecondaryIndexUpdates",
        .provisioned_write_capacity_auto_scaling_update = "ProvisionedWriteCapacityAutoScalingUpdate",
        .replica_updates = "ReplicaUpdates",
        .table_name = "TableName",
    };
};

pub const UpdateTableReplicaAutoScalingOutput = struct {
    /// Returns information about the auto scaling settings of a table with
    /// replicas.
    table_auto_scaling_description: ?TableAutoScalingDescription = null,

    pub const json_field_names = .{
        .table_auto_scaling_description = "TableAutoScalingDescription",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateTableReplicaAutoScalingInput, options: CallOptions) !UpdateTableReplicaAutoScalingOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dynamodb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateTableReplicaAutoScalingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dynamodb", "DynamoDB", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "DynamoDB_20120810.UpdateTableReplicaAutoScaling");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateTableReplicaAutoScalingOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateTableReplicaAutoScalingOutput, body, allocator);
}
