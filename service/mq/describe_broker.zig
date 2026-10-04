const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ActionRequired = @import("action_required.zig").ActionRequired;
const AuthenticationStrategy = @import("authentication_strategy.zig").AuthenticationStrategy;
const BrokerInstance = @import("broker_instance.zig").BrokerInstance;
const BrokerState = @import("broker_state.zig").BrokerState;
const Configurations = @import("configurations.zig").Configurations;
const DataReplicationMetadataOutput = @import("data_replication_metadata_output.zig").DataReplicationMetadataOutput;
const DataReplicationMode = @import("data_replication_mode.zig").DataReplicationMode;
const DeploymentMode = @import("deployment_mode.zig").DeploymentMode;
const EncryptionOptions = @import("encryption_options.zig").EncryptionOptions;
const EngineType = @import("engine_type.zig").EngineType;
const LdapServerMetadataOutput = @import("ldap_server_metadata_output.zig").LdapServerMetadataOutput;
const LogsSummary = @import("logs_summary.zig").LogsSummary;
const WeeklyStartTime = @import("weekly_start_time.zig").WeeklyStartTime;
const BrokerStorageType = @import("broker_storage_type.zig").BrokerStorageType;
const UserSummary = @import("user_summary.zig").UserSummary;

pub const DescribeBrokerInput = struct {
    /// The unique ID that Amazon MQ generates for the broker.
    broker_id: []const u8,

    pub const json_field_names = .{
        .broker_id = "BrokerId",
    };
};

pub const DescribeBrokerOutput = struct {
    /// Actions required for a broker.
    actions_required: ?[]const ActionRequired = null,

    /// The authentication strategy used to secure the broker. The default is
    /// SIMPLE.
    authentication_strategy: ?AuthenticationStrategy = null,

    /// Enables automatic upgrades to new patch versions for brokers as new versions
    /// are released and supported by Amazon MQ. Automatic upgrades occur during the
    /// scheduled maintenance window or after a manual broker reboot.
    auto_minor_version_upgrade: ?bool = null,

    /// The broker's Amazon Resource Name (ARN).
    broker_arn: ?[]const u8 = null,

    /// The unique ID that Amazon MQ generates for the broker.
    broker_id: ?[]const u8 = null,

    /// A list of information about allocated brokers.
    broker_instances: ?[]const BrokerInstance = null,

    /// The broker's name. This value must be unique in your Amazon Web Services
    /// account account, 1-50 characters long, must contain only letters, numbers,
    /// dashes, and underscores, and must not contain white spaces, brackets,
    /// wildcard characters, or special characters.
    broker_name: ?[]const u8 = null,

    /// The broker's status.
    broker_state: ?BrokerState = null,

    /// The list of all revisions for the specified configuration.
    configurations: ?Configurations = null,

    /// The time when the broker was created.
    created: ?i64 = null,

    /// The replication details of the data replication-enabled broker. Only
    /// returned if dataReplicationMode is set to CRDR.
    data_replication_metadata: ?DataReplicationMetadataOutput = null,

    /// Describes whether this broker is a part of a data replication pair.
    data_replication_mode: ?DataReplicationMode = null,

    /// The broker's deployment mode.
    deployment_mode: ?DeploymentMode = null,

    /// Encryption options for the broker.
    encryption_options: ?EncryptionOptions = null,

    /// The type of broker engine. Currently, Amazon MQ supports ACTIVEMQ and
    /// RABBITMQ.
    engine_type: ?EngineType = null,

    /// The broker engine version. For more information, see the [ActiveMQ version
    /// management](https://docs.aws.amazon.com//amazon-mq/latest/developer-guide/activemq-version-management.html) and the [RabbitMQ version management](https://docs.aws.amazon.com//amazon-mq/latest/developer-guide/rabbitmq-version-management.html) sections in the Amazon MQ Developer Guide.
    engine_version: ?[]const u8 = null,

    /// The broker's instance type.
    host_instance_type: ?[]const u8 = null,

    /// The metadata of the LDAP server used to authenticate and authorize
    /// connections to the broker.
    ldap_server_metadata: ?LdapServerMetadataOutput = null,

    /// The list of information about logs currently enabled and pending to be
    /// deployed for the specified broker.
    logs: ?LogsSummary = null,

    /// The parameters that determine the WeeklyStartTime.
    maintenance_window_start_time: ?WeeklyStartTime = null,

    /// The authentication strategy that will be applied when the broker is
    /// rebooted. The default is SIMPLE.
    pending_authentication_strategy: ?AuthenticationStrategy = null,

    /// The pending replication details of the data replication-enabled broker. Only
    /// returned if pendingDataReplicationMode is set to CRDR.
    pending_data_replication_metadata: ?DataReplicationMetadataOutput = null,

    /// Describes whether this broker will be a part of a data replication pair
    /// after reboot.
    pending_data_replication_mode: ?DataReplicationMode = null,

    /// The broker engine version to upgrade to. For more information, see the
    /// [ActiveMQ version
    /// management](https://docs.aws.amazon.com//amazon-mq/latest/developer-guide/activemq-version-management.html) and the [RabbitMQ version management](https://docs.aws.amazon.com//amazon-mq/latest/developer-guide/rabbitmq-version-management.html) sections in the Amazon MQ Developer Guide.
    pending_engine_version: ?[]const u8 = null,

    /// The broker's host instance type to upgrade to. For a list of supported
    /// instance types, see [Broker instance
    /// types](https://docs.aws.amazon.com//amazon-mq/latest/developer-guide/broker.html#broker-instance-types).
    pending_host_instance_type: ?[]const u8 = null,

    /// The metadata of the LDAP server that will be used to authenticate and
    /// authorize connections to the broker after it is rebooted.
    pending_ldap_server_metadata: ?LdapServerMetadataOutput = null,

    /// The list of pending security groups to authorize connections to brokers.
    pending_security_groups: ?[]const []const u8 = null,

    /// The pending storage size in GB, to be applied on the next broker restart.
    pending_storage_size: ?i32 = null,

    /// Enables connections from applications outside of the VPC that hosts the
    /// broker's subnets.
    publicly_accessible: ?bool = null,

    /// The list of rules (1 minimum, 125 maximum) that authorize connections to
    /// brokers.
    security_groups: ?[]const []const u8 = null,

    /// The broker's storage size in GB.
    storage_size: ?i32 = null,

    /// The broker's storage type.
    storage_type: ?BrokerStorageType = null,

    /// The list of groups that define which subnets and IP ranges the broker can
    /// use from different Availability Zones.
    subnet_ids: ?[]const []const u8 = null,

    /// The list of all tags associated with this broker.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The list of all broker usernames for the specified broker.
    users: ?[]const UserSummary = null,

    pub const json_field_names = .{
        .actions_required = "ActionsRequired",
        .authentication_strategy = "AuthenticationStrategy",
        .auto_minor_version_upgrade = "AutoMinorVersionUpgrade",
        .broker_arn = "BrokerArn",
        .broker_id = "BrokerId",
        .broker_instances = "BrokerInstances",
        .broker_name = "BrokerName",
        .broker_state = "BrokerState",
        .configurations = "Configurations",
        .created = "Created",
        .data_replication_metadata = "DataReplicationMetadata",
        .data_replication_mode = "DataReplicationMode",
        .deployment_mode = "DeploymentMode",
        .encryption_options = "EncryptionOptions",
        .engine_type = "EngineType",
        .engine_version = "EngineVersion",
        .host_instance_type = "HostInstanceType",
        .ldap_server_metadata = "LdapServerMetadata",
        .logs = "Logs",
        .maintenance_window_start_time = "MaintenanceWindowStartTime",
        .pending_authentication_strategy = "PendingAuthenticationStrategy",
        .pending_data_replication_metadata = "PendingDataReplicationMetadata",
        .pending_data_replication_mode = "PendingDataReplicationMode",
        .pending_engine_version = "PendingEngineVersion",
        .pending_host_instance_type = "PendingHostInstanceType",
        .pending_ldap_server_metadata = "PendingLdapServerMetadata",
        .pending_security_groups = "PendingSecurityGroups",
        .pending_storage_size = "PendingStorageSize",
        .publicly_accessible = "PubliclyAccessible",
        .security_groups = "SecurityGroups",
        .storage_size = "StorageSize",
        .storage_type = "StorageType",
        .subnet_ids = "SubnetIds",
        .tags = "Tags",
        .users = "Users",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeBrokerInput, options: CallOptions) !DescribeBrokerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeBrokerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mq", "mq", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/brokers/");
    try path_buf.appendSlice(allocator, input.broker_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeBrokerOutput {
    const result: DescribeBrokerOutput = try aws.json.parseJsonObject(
        DescribeBrokerOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
