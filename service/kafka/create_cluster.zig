const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const BrokerNodeGroupInfo = @import("broker_node_group_info.zig").BrokerNodeGroupInfo;
const ClientAuthentication = @import("client_authentication.zig").ClientAuthentication;
const ConfigurationInfo = @import("configuration_info.zig").ConfigurationInfo;
const EncryptionInfo = @import("encryption_info.zig").EncryptionInfo;
const EnhancedMonitoring = @import("enhanced_monitoring.zig").EnhancedMonitoring;
const LoggingInfo = @import("logging_info.zig").LoggingInfo;
const OpenMonitoringInfo = @import("open_monitoring_info.zig").OpenMonitoringInfo;
const Rebalancing = @import("rebalancing.zig").Rebalancing;
const StorageMode = @import("storage_mode.zig").StorageMode;
const ClusterState = @import("cluster_state.zig").ClusterState;

pub const CreateClusterInput = struct {
    /// Information about the broker nodes in the cluster.
    broker_node_group_info: BrokerNodeGroupInfo,

    /// Includes all client authentication related information.
    client_authentication: ?ClientAuthentication = null,

    /// The name of the cluster.
    cluster_name: []const u8,

    /// Represents the configuration that you want MSK to use for the brokers in a
    /// cluster.
    configuration_info: ?ConfigurationInfo = null,

    /// Includes all encryption-related information.
    encryption_info: ?EncryptionInfo = null,

    /// Specifies the level of monitoring for the MSK cluster. The possible values
    /// are DEFAULT, PER_BROKER, PER_TOPIC_PER_BROKER, and PER_TOPIC_PER_PARTITION.
    enhanced_monitoring: ?EnhancedMonitoring = null,

    /// The version of Apache Kafka.
    kafka_version: []const u8,

    logging_info: ?LoggingInfo = null,

    /// The number of broker nodes in the cluster.
    number_of_broker_nodes: i32,

    /// The settings for open monitoring.
    open_monitoring: ?OpenMonitoringInfo = null,

    /// Specifies if intelligent rebalancing should be turned on for the new MSK
    /// Provisioned cluster with Express brokers. By default, intelligent
    /// rebalancing status is ACTIVE for all new clusters.
    rebalancing: ?Rebalancing = null,

    /// This controls storage mode for supported storage tiers.
    storage_mode: ?StorageMode = null,

    /// Create tags when creating the cluster.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .broker_node_group_info = "BrokerNodeGroupInfo",
        .client_authentication = "ClientAuthentication",
        .cluster_name = "ClusterName",
        .configuration_info = "ConfigurationInfo",
        .encryption_info = "EncryptionInfo",
        .enhanced_monitoring = "EnhancedMonitoring",
        .kafka_version = "KafkaVersion",
        .logging_info = "LoggingInfo",
        .number_of_broker_nodes = "NumberOfBrokerNodes",
        .open_monitoring = "OpenMonitoring",
        .rebalancing = "Rebalancing",
        .storage_mode = "StorageMode",
        .tags = "Tags",
    };
};

pub const CreateClusterOutput = struct {
    /// The Amazon Resource Name (ARN) of the cluster.
    cluster_arn: ?[]const u8 = null,

    /// The name of the MSK cluster.
    cluster_name: ?[]const u8 = null,

    /// The state of the cluster. The possible states are ACTIVE, CREATING,
    /// DELETING, FAILED, HEALING, MAINTENANCE, REBOOTING_BROKER, and UPDATING.
    state: ?ClusterState = null,

    pub const json_field_names = .{
        .cluster_arn = "ClusterArn",
        .cluster_name = "ClusterName",
        .state = "State",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateClusterInput, options: CallOptions) !CreateClusterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "kafka");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateClusterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kafka", "Kafka", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/v1/clusters";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"BrokerNodeGroupInfo\":");
    try aws.json.writeValue(@TypeOf(input.broker_node_group_info), input.broker_node_group_info, allocator, &body_buf);
    has_prev = true;
    if (input.client_authentication) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientAuthentication\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ClusterName\":");
    try aws.json.writeValue(@TypeOf(input.cluster_name), input.cluster_name, allocator, &body_buf);
    has_prev = true;
    if (input.configuration_info) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ConfigurationInfo\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.encryption_info) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EncryptionInfo\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.enhanced_monitoring) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EnhancedMonitoring\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"KafkaVersion\":");
    try aws.json.writeValue(@TypeOf(input.kafka_version), input.kafka_version, allocator, &body_buf);
    has_prev = true;
    if (input.logging_info) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LoggingInfo\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"NumberOfBrokerNodes\":");
    try aws.json.writeValue(@TypeOf(input.number_of_broker_nodes), input.number_of_broker_nodes, allocator, &body_buf);
    has_prev = true;
    if (input.open_monitoring) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OpenMonitoring\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.rebalancing) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Rebalancing\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.storage_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StorageMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateClusterOutput {
    var result: CreateClusterOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateClusterOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ForbiddenException")) {
        return .{ .arena = arena, .kind = .{ .forbidden_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
