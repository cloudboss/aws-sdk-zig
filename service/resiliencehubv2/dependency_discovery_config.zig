const DependencyDiscoveryStatus = @import("dependency_discovery_status.zig").DependencyDiscoveryStatus;

/// Configuration for dependency discovery on a service.
pub const DependencyDiscoveryConfig = struct {
    /// The count of resources eligible for dependency attribution.
    eligible_resource_count: ?i32 = null,

    /// A status message for dependency discovery, displayed during the
    /// initialization state.
    message: ?[]const u8 = null,

    /// The current status of dependency discovery.
    status: DependencyDiscoveryStatus,

    /// The timestamp when dependency discovery was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .eligible_resource_count = "eligibleResourceCount",
        .message = "message",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
