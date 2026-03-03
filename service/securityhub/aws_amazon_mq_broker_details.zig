const AwsAmazonMqBrokerEncryptionOptionsDetails = @import("aws_amazon_mq_broker_encryption_options_details.zig").AwsAmazonMqBrokerEncryptionOptionsDetails;
const AwsAmazonMqBrokerLdapServerMetadataDetails = @import("aws_amazon_mq_broker_ldap_server_metadata_details.zig").AwsAmazonMqBrokerLdapServerMetadataDetails;
const AwsAmazonMqBrokerLogsDetails = @import("aws_amazon_mq_broker_logs_details.zig").AwsAmazonMqBrokerLogsDetails;
const AwsAmazonMqBrokerMaintenanceWindowStartTimeDetails = @import("aws_amazon_mq_broker_maintenance_window_start_time_details.zig").AwsAmazonMqBrokerMaintenanceWindowStartTimeDetails;
const AwsAmazonMqBrokerUsersDetails = @import("aws_amazon_mq_broker_users_details.zig").AwsAmazonMqBrokerUsersDetails;

/// Provides details about an Amazon MQ message broker. A message broker allows
/// software applications and
/// components to communicate using various programming languages, operating
/// systems, and formal messaging protocols.
pub const AwsAmazonMqBrokerDetails = struct {
    /// The authentication strategy used to secure the broker. The default is
    /// `SIMPLE`.
    authentication_strategy: ?[]const u8 = null,

    /// Whether automatically upgrade new minor versions for brokers, as new
    /// versions are released and supported by Amazon MQ.
    /// Automatic upgrades occur during the scheduled maintenance window of the
    /// broker or after a manual broker reboot.
    auto_minor_version_upgrade: ?bool = null,

    /// The Amazon Resource Name (ARN) of the broker.
    broker_arn: ?[]const u8 = null,

    /// The unique ID that Amazon MQ generates for the broker.
    broker_id: ?[]const u8 = null,

    /// The broker's name.
    broker_name: ?[]const u8 = null,

    /// The broker's deployment mode.
    deployment_mode: ?[]const u8 = null,

    /// Encryption options for the broker. Doesn’t apply to RabbitMQ brokers.
    encryption_options: ?AwsAmazonMqBrokerEncryptionOptionsDetails = null,

    /// The type of broker engine.
    engine_type: ?[]const u8 = null,

    /// The version of the broker engine.
    engine_version: ?[]const u8 = null,

    /// The broker's instance type.
    host_instance_type: ?[]const u8 = null,

    /// The metadata of the Lightweight Directory Access Protocol (LDAP) server used
    /// to authenticate and authorize connections to the broker. This is an optional
    /// failover server.
    ldap_server_metadata: ?AwsAmazonMqBrokerLdapServerMetadataDetails = null,

    /// Turns on Amazon CloudWatch logging for brokers.
    logs: ?AwsAmazonMqBrokerLogsDetails = null,

    /// The scheduled time period (UTC) during which Amazon MQ begins to apply
    /// pending updates or patches to the broker.
    maintenance_window_start_time: ?AwsAmazonMqBrokerMaintenanceWindowStartTimeDetails = null,

    /// Permits connections from applications outside of the VPC that hosts the
    /// broker's subnets.
    publicly_accessible: ?bool = null,

    /// The list of rules (one minimum, 125 maximum) that authorize connections to
    /// brokers.
    security_groups: ?[]const []const u8 = null,

    /// The broker's storage type.
    storage_type: ?[]const u8 = null,

    /// The list of groups that define which subnets and IP ranges the broker can
    /// use from different Availability Zones.
    subnet_ids: ?[]const []const u8 = null,

    /// The list of all broker usernames for the specified broker. Doesn't apply to
    /// RabbitMQ brokers.
    users: ?[]const AwsAmazonMqBrokerUsersDetails = null,

    pub const json_field_names = .{
        .authentication_strategy = "AuthenticationStrategy",
        .auto_minor_version_upgrade = "AutoMinorVersionUpgrade",
        .broker_arn = "BrokerArn",
        .broker_id = "BrokerId",
        .broker_name = "BrokerName",
        .deployment_mode = "DeploymentMode",
        .encryption_options = "EncryptionOptions",
        .engine_type = "EngineType",
        .engine_version = "EngineVersion",
        .host_instance_type = "HostInstanceType",
        .ldap_server_metadata = "LdapServerMetadata",
        .logs = "Logs",
        .maintenance_window_start_time = "MaintenanceWindowStartTime",
        .publicly_accessible = "PubliclyAccessible",
        .security_groups = "SecurityGroups",
        .storage_type = "StorageType",
        .subnet_ids = "SubnetIds",
        .users = "Users",
    };
};
