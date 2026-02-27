const SourceNetworkData = @import("source_network_data.zig").SourceNetworkData;

/// Properties of resource related to a job event.
pub const EventResourceData = union(enum) {
    /// Source Network properties.
    source_network_data: ?SourceNetworkData,

    pub const json_field_names = .{
        .source_network_data = "sourceNetworkData",
    };
};
