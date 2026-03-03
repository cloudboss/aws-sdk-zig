const MatterCapabilityReportCluster = @import("matter_capability_report_cluster.zig").MatterCapabilityReportCluster;

/// Matter endpoint used in capability report.
pub const MatterCapabilityReportEndpoint = struct {
    /// Semantic information related to endpoint.
    client_clusters: ?[]const []const u8 = null,

    /// Matter clusters used in capability report.
    clusters: []const MatterCapabilityReportCluster,

    /// The type of device.
    device_types: []const []const u8,

    /// The id of the Amazon Web Services Matter capability report endpoint.
    id: []const u8,

    /// Heirachy of child endpoints contained in the given endpoint.
    parts: ?[]const []const u8 = null,

    /// Semantic information related to endpoint.
    semantic_tags: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .client_clusters = "clientClusters",
        .clusters = "clusters",
        .device_types = "deviceTypes",
        .id = "id",
        .parts = "parts",
        .semantic_tags = "semanticTags",
    };
};
