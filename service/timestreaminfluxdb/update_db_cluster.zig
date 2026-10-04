const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DbInstanceType = @import("db_instance_type.zig").DbInstanceType;
const FailoverMode = @import("failover_mode.zig").FailoverMode;
const LogDeliveryConfiguration = @import("log_delivery_configuration.zig").LogDeliveryConfiguration;
const MaintenanceSchedule = @import("maintenance_schedule.zig").MaintenanceSchedule;
const ClusterStatus = @import("cluster_status.zig").ClusterStatus;

pub const UpdateDbClusterInput = struct {
    /// Service-generated unique identifier of the DB cluster to update.
    db_cluster_id: []const u8,

    /// Update the DB cluster to use the specified DB instance Type.
    db_instance_type: ?DbInstanceType = null,

    /// Update the DB cluster to use the specified DB parameter group.
    db_parameter_group_identifier: ?[]const u8 = null,

    /// Update the DB cluster's failover behavior.
    failover_mode: ?FailoverMode = null,

    /// The log delivery configuration to apply to the DB cluster.
    log_delivery_configuration: ?LogDeliveryConfiguration = null,

    /// Specifies the maintenance schedule for the DB cluster, including the
    /// preferred maintenance window and timezone.
    maintenance_schedule: ?MaintenanceSchedule = null,

    /// Update the DB cluster to use the specified port.
    port: ?i32 = null,

    pub const json_field_names = .{
        .db_cluster_id = "dbClusterId",
        .db_instance_type = "dbInstanceType",
        .db_parameter_group_identifier = "dbParameterGroupIdentifier",
        .failover_mode = "failoverMode",
        .log_delivery_configuration = "logDeliveryConfiguration",
        .maintenance_schedule = "maintenanceSchedule",
        .port = "port",
    };
};

pub const UpdateDbClusterOutput = struct {
    /// The status of the DB cluster.
    db_cluster_status: ?ClusterStatus = null,

    pub const json_field_names = .{
        .db_cluster_status = "dbClusterStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDbClusterInput, options: CallOptions) !UpdateDbClusterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "timestream-influxdb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDbClusterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("timestream-influxdb", "Timestream InfluxDB", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonTimestreamInfluxDB.UpdateDbCluster");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDbClusterOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateDbClusterOutput, body, allocator);
}
