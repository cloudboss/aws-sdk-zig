const OpenSearchPartitionInstanceType = @import("open_search_partition_instance_type.zig").OpenSearchPartitionInstanceType;

/// Lists all instance types and available features for a given OpenSearch or
/// Elasticsearch
/// version.
pub const InstanceTypeDetails = struct {
    /// Whether fine-grained access control is supported for the instance type.
    advanced_security_enabled: ?bool,

    /// Whether logging is supported for the instance type.
    app_logs_enabled: ?bool,

    /// The supported Availability Zones for the instance type.
    availability_zones: ?[]const []const u8,

    /// Whether Amazon Cognito access is supported for the instance type.
    cognito_enabled: ?bool,

    /// Whether encryption at rest and node-to-node encryption are supported for the
    /// instance
    /// type.
    encryption_enabled: ?bool,

    /// Whether the instance acts as a data node, a dedicated master node, or an
    /// UltraWarm
    /// node.
    instance_role: ?[]const []const u8,

    /// The instance type.
    instance_type: ?OpenSearchPartitionInstanceType,

    /// Whether UltraWarm is supported for the instance type.
    warm_enabled: ?bool,

    pub const json_field_names = .{
        .advanced_security_enabled = "AdvancedSecurityEnabled",
        .app_logs_enabled = "AppLogsEnabled",
        .availability_zones = "AvailabilityZones",
        .cognito_enabled = "CognitoEnabled",
        .encryption_enabled = "EncryptionEnabled",
        .instance_role = "InstanceRole",
        .instance_type = "InstanceType",
        .warm_enabled = "WarmEnabled",
    };
};
