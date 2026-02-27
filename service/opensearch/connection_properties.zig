const CrossClusterSearchConnectionProperties = @import("cross_cluster_search_connection_properties.zig").CrossClusterSearchConnectionProperties;

/// The connection properties of an outbound connection.
pub const ConnectionProperties = struct {
    /// The connection properties for cross cluster search.
    cross_cluster_search: ?CrossClusterSearchConnectionProperties,

    /// The Endpoint attribute cannot be modified.
    ///
    /// The endpoint of the remote domain. Applicable for VPC_ENDPOINT connection
    /// mode.
    endpoint: ?[]const u8,

    pub const json_field_names = .{
        .cross_cluster_search = "CrossClusterSearch",
        .endpoint = "Endpoint",
    };
};
