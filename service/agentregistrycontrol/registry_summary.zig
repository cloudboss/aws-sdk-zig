const AutoDetection = @import("auto_detection.zig").AutoDetection;
const DiscoveryConfiguration = @import("discovery_configuration.zig").DiscoveryConfiguration;
const RegistryStatus = @import("registry_status.zig").RegistryStatus;

/// Registry summary for list operations
pub const RegistrySummary = struct {
    /// The registry's auto-detection properties, including the requested
    /// configuration and the current detection status. Present only when
    /// auto-detection was configured for the registry.
    auto_detection: ?AutoDetection = null,

    /// The timestamp when the registry was created
    created_at: i64,

    /// Registry description
    description: ?[]const u8 = null,

    /// Discovery configuration for the registry
    discovery_configuration: ?DiscoveryConfiguration = null,

    /// Registry name
    name: []const u8,

    /// Registry Amazon Resource Name
    registry_arn: []const u8,

    /// Unique registry identifier
    registry_id: []const u8,

    /// Current status of the registry
    status: RegistryStatus,

    /// The reason for the current status. Typically populated when the status
    /// indicates a failure state.
    status_reason: ?[]const u8 = null,

    /// The timestamp when the registry was last updated
    updated_at: i64,

    pub const json_field_names = .{
        .auto_detection = "autoDetection",
        .created_at = "createdAt",
        .description = "description",
        .discovery_configuration = "discoveryConfiguration",
        .name = "name",
        .registry_arn = "registryArn",
        .registry_id = "registryId",
        .status = "status",
        .status_reason = "statusReason",
        .updated_at = "updatedAt",
    };
};
