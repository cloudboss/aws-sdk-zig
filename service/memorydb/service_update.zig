const ServiceUpdateStatus = @import("service_update_status.zig").ServiceUpdateStatus;
const ServiceUpdateType = @import("service_update_type.zig").ServiceUpdateType;

/// An update that you can apply to your MemoryDB clusters.
pub const ServiceUpdate = struct {
    /// The date at which the service update will be automatically applied
    auto_update_start_date: ?i64,

    /// The name of the cluster to which the service update applies
    cluster_name: ?[]const u8,

    /// Provides details of the service update
    description: ?[]const u8,

    /// The name of the engine for which a service update is available.
    engine: ?[]const u8,

    /// A list of nodes updated by the service update
    nodes_updated: ?[]const u8,

    /// The date when the service update is initially available
    release_date: ?i64,

    /// The unique ID of the service update
    service_update_name: ?[]const u8,

    /// The status of the service update
    status: ?ServiceUpdateStatus,

    /// Reflects the nature of the service update
    @"type": ?ServiceUpdateType,

    pub const json_field_names = .{
        .auto_update_start_date = "AutoUpdateStartDate",
        .cluster_name = "ClusterName",
        .description = "Description",
        .engine = "Engine",
        .nodes_updated = "NodesUpdated",
        .release_date = "ReleaseDate",
        .service_update_name = "ServiceUpdateName",
        .status = "Status",
        .@"type" = "Type",
    };
};
