const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Cluster = @import("cluster.zig").Cluster;

pub const UpdateClusterInput = struct {
    /// The name of the DAX cluster to be modified.
    cluster_name: []const u8,

    /// A description of the changes being made to the cluster.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) that identifies the topic.
    notification_topic_arn: ?[]const u8 = null,

    /// The current state of the topic. A value of “active” means that notifications
    /// will
    /// be sent to the topic. A value of “inactive” means that notifications will
    /// not be sent to
    /// the topic.
    notification_topic_status: ?[]const u8 = null,

    /// The name of a parameter group for this cluster.
    parameter_group_name: ?[]const u8 = null,

    /// A range of time when maintenance of DAX cluster software will be performed.
    /// For
    /// example: `sun:01:00-sun:09:00`. Cluster maintenance normally takes less than
    /// 30 minutes, and is performed automatically within the maintenance window.
    preferred_maintenance_window: ?[]const u8 = null,

    /// A list of user-specified security group IDs to be assigned to each node in
    /// the DAX
    /// cluster. If this parameter is not specified, DAX assigns the default VPC
    /// security group
    /// to each node.
    security_group_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .cluster_name = "ClusterName",
        .description = "Description",
        .notification_topic_arn = "NotificationTopicArn",
        .notification_topic_status = "NotificationTopicStatus",
        .parameter_group_name = "ParameterGroupName",
        .preferred_maintenance_window = "PreferredMaintenanceWindow",
        .security_group_ids = "SecurityGroupIds",
    };
};

pub const UpdateClusterOutput = struct {
    /// A description of the DAX cluster, after it has been modified.
    cluster: ?Cluster = null,

    pub const json_field_names = .{
        .cluster = "Cluster",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateClusterInput, options: CallOptions) !UpdateClusterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dax", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateClusterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dax", "DAX", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDAXV3.UpdateCluster");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateClusterOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateClusterOutput, body, allocator);
}
