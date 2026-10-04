const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthenticationStrategy = @import("authentication_strategy.zig").AuthenticationStrategy;
const ConfigurationId = @import("configuration_id.zig").ConfigurationId;
const DataReplicationMode = @import("data_replication_mode.zig").DataReplicationMode;
const LdapServerMetadataInput = @import("ldap_server_metadata_input.zig").LdapServerMetadataInput;
const Logs = @import("logs.zig").Logs;
const WeeklyStartTime = @import("weekly_start_time.zig").WeeklyStartTime;
const DataReplicationMetadataOutput = @import("data_replication_metadata_output.zig").DataReplicationMetadataOutput;
const LdapServerMetadataOutput = @import("ldap_server_metadata_output.zig").LdapServerMetadataOutput;

pub const UpdateBrokerInput = struct {
    /// Optional. The authentication strategy used to secure the broker. The default
    /// is SIMPLE.
    authentication_strategy: ?AuthenticationStrategy = null,

    /// Enables automatic upgrades to new patch versions for brokers as new versions
    /// are released and supported by Amazon MQ. Automatic upgrades occur during the
    /// scheduled maintenance window or after a manual broker reboot.
    ///
    /// Must be set to true for ActiveMQ brokers version 5.18 and above and for
    /// RabbitMQ brokers version 3.13 and above.
    auto_minor_version_upgrade: ?bool = null,

    /// The unique ID that Amazon MQ generates for the broker.
    broker_id: []const u8,

    /// A list of information about the configuration.
    configuration: ?ConfigurationId = null,

    /// Defines whether this broker is a part of a data replication pair.
    data_replication_mode: ?DataReplicationMode = null,

    /// The broker engine version. For more information, see the [ActiveMQ version
    /// management](https://docs.aws.amazon.com//amazon-mq/latest/developer-guide/activemq-version-management.html) and the [RabbitMQ version management](https://docs.aws.amazon.com//amazon-mq/latest/developer-guide/rabbitmq-version-management.html) sections in the Amazon MQ Developer Guide.
    ///
    /// When upgrading to ActiveMQ version 5.18 and above or RabbitMQ version 3.13
    /// and above, you must have autoMinorVersionUpgrade set to true for the broker.
    engine_version: ?[]const u8 = null,

    /// The broker's host instance type to upgrade to. For a list of supported
    /// instance types, see [Broker instance
    /// types](https://docs.aws.amazon.com//amazon-mq/latest/developer-guide/broker.html#broker-instance-types).
    host_instance_type: ?[]const u8 = null,

    /// Optional. The metadata of the LDAP server used to authenticate and authorize
    /// connections to the broker. Does not apply to RabbitMQ brokers.
    ldap_server_metadata: ?LdapServerMetadataInput = null,

    /// Enables Amazon CloudWatch logging for brokers.
    logs: ?Logs = null,

    /// The parameters that determine the WeeklyStartTime.
    maintenance_window_start_time: ?WeeklyStartTime = null,

    /// The list of resource shares to update on the broker
    resource_share_arns: ?[]const []const u8 = null,

    /// The list of security groups (1 minimum, 5 maximum) that authorizes
    /// connections to brokers.
    security_groups: ?[]const []const u8 = null,

    /// The broker's storage size in GB.
    storage_size: ?i32 = null,

    pub const json_field_names = .{
        .authentication_strategy = "AuthenticationStrategy",
        .auto_minor_version_upgrade = "AutoMinorVersionUpgrade",
        .broker_id = "BrokerId",
        .configuration = "Configuration",
        .data_replication_mode = "DataReplicationMode",
        .engine_version = "EngineVersion",
        .host_instance_type = "HostInstanceType",
        .ldap_server_metadata = "LdapServerMetadata",
        .logs = "Logs",
        .maintenance_window_start_time = "MaintenanceWindowStartTime",
        .resource_share_arns = "ResourceShareArns",
        .security_groups = "SecurityGroups",
        .storage_size = "StorageSize",
    };
};

pub const UpdateBrokerOutput = struct {
    /// Optional. The authentication strategy used to secure the broker. The default
    /// is SIMPLE.
    authentication_strategy: ?AuthenticationStrategy = null,

    /// Enables automatic upgrades to new patch versions for brokers as new versions
    /// are released and supported by Amazon MQ. Automatic upgrades occur during the
    /// scheduled maintenance window or after a manual broker reboot.
    auto_minor_version_upgrade: ?bool = null,

    /// Required. The unique ID that Amazon MQ generates for the broker.
    broker_id: ?[]const u8 = null,

    /// The ID of the updated configuration.
    configuration: ?ConfigurationId = null,

    /// The replication details of the data replication-enabled broker. Only
    /// returned if dataReplicationMode is set to CRDR.
    data_replication_metadata: ?DataReplicationMetadataOutput = null,

    /// Describes whether this broker is a part of a data replication pair.
    data_replication_mode: ?DataReplicationMode = null,

    /// The broker engine version to upgrade to. For more information, see the
    /// [ActiveMQ version
    /// management](https://docs.aws.amazon.com//amazon-mq/latest/developer-guide/activemq-version-management.html) and the [RabbitMQ version management](https://docs.aws.amazon.com//amazon-mq/latest/developer-guide/rabbitmq-version-management.html) sections in the Amazon MQ Developer Guide.
    engine_version: ?[]const u8 = null,

    /// The broker's host instance type to upgrade to. For a list of supported
    /// instance types, see [Broker instance
    /// types](https://docs.aws.amazon.com//amazon-mq/latest/developer-guide/broker.html#broker-instance-types).
    host_instance_type: ?[]const u8 = null,

    /// Optional. The metadata of the LDAP server used to authenticate and authorize
    /// connections to the broker. Does not apply to RabbitMQ brokers.
    ldap_server_metadata: ?LdapServerMetadataOutput = null,

    /// The list of information about logs to be enabled for the specified broker.
    logs: ?Logs = null,

    /// The parameters that determine the WeeklyStartTime.
    maintenance_window_start_time: ?WeeklyStartTime = null,

    /// The pending replication details of the data replication-enabled broker. Only
    /// returned if pendingDataReplicationMode is set to CRDR.
    pending_data_replication_metadata: ?DataReplicationMetadataOutput = null,

    /// Describes whether this broker will be a part of a data replication pair
    /// after reboot.
    pending_data_replication_mode: ?DataReplicationMode = null,

    /// The pending broker's target list of resource shares
    resource_share_arns: ?[]const []const u8 = null,

    /// The list of security groups (1 minimum, 5 maximum) that authorizes
    /// connections to brokers.
    security_groups: ?[]const []const u8 = null,

    /// The broker's storage size in GB.
    storage_size: ?i32 = null,

    pub const json_field_names = .{
        .authentication_strategy = "AuthenticationStrategy",
        .auto_minor_version_upgrade = "AutoMinorVersionUpgrade",
        .broker_id = "BrokerId",
        .configuration = "Configuration",
        .data_replication_metadata = "DataReplicationMetadata",
        .data_replication_mode = "DataReplicationMode",
        .engine_version = "EngineVersion",
        .host_instance_type = "HostInstanceType",
        .ldap_server_metadata = "LdapServerMetadata",
        .logs = "Logs",
        .maintenance_window_start_time = "MaintenanceWindowStartTime",
        .pending_data_replication_metadata = "PendingDataReplicationMetadata",
        .pending_data_replication_mode = "PendingDataReplicationMode",
        .resource_share_arns = "ResourceShareArns",
        .security_groups = "SecurityGroups",
        .storage_size = "StorageSize",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateBrokerInput, options: CallOptions) !UpdateBrokerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mq", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateBrokerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mq", "mq", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/brokers/");
    try path_buf.appendSlice(allocator, input.broker_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.authentication_strategy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AuthenticationStrategy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.auto_minor_version_upgrade) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AutoMinorVersionUpgrade\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Configuration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.data_replication_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DataReplicationMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.engine_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EngineVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.host_instance_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"HostInstanceType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ldap_server_metadata) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LdapServerMetadata\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.logs) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Logs\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.maintenance_window_start_time) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaintenanceWindowStartTime\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.resource_share_arns) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ResourceShareArns\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.security_groups) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SecurityGroups\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.storage_size) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StorageSize\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateBrokerOutput {
    const result: UpdateBrokerOutput = try aws.json.parseJsonObject(
        UpdateBrokerOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
