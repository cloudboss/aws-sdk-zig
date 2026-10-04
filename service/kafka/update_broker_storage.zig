const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BrokerEBSVolumeInfo = @import("broker_ebs_volume_info.zig").BrokerEBSVolumeInfo;

pub const UpdateBrokerStorageInput = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies the cluster.
    cluster_arn: []const u8,

    /// The version of cluster to update from. A successful operation will then
    /// generate a new version.
    current_version: []const u8,

    /// Describes the target volume size and the ID of the broker to apply the
    /// update to.
    target_broker_ebs_volume_info: []const BrokerEBSVolumeInfo,

    pub const json_field_names = .{
        .cluster_arn = "ClusterArn",
        .current_version = "CurrentVersion",
        .target_broker_ebs_volume_info = "TargetBrokerEBSVolumeInfo",
    };
};

pub const UpdateBrokerStorageOutput = struct {
    /// The Amazon Resource Name (ARN) of the cluster.
    cluster_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the cluster operation.
    cluster_operation_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster_arn = "ClusterArn",
        .cluster_operation_arn = "ClusterOperationArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateBrokerStorageInput, options: CallOptions) !UpdateBrokerStorageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kafka", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateBrokerStorageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kafka", "Kafka", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/clusters/");
    try path_buf.appendSlice(allocator, input.cluster_arn);
    try path_buf.appendSlice(allocator, "/nodes/storage");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"CurrentVersion\":");
    try aws.json.writeValue(@TypeOf(input.current_version), input.current_version, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TargetBrokerEBSVolumeInfo\":");
    try aws.json.writeValue(@TypeOf(input.target_broker_ebs_volume_info), input.target_broker_ebs_volume_info, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateBrokerStorageOutput {
    const result: UpdateBrokerStorageOutput = try aws.json.parseJsonObject(
        UpdateBrokerStorageOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
