const FleetIndexingApi = @import("fleet_indexing_api.zig").FleetIndexingApi;

/// Provides connectivity filter selections for the fleet indexing
/// configuration.
pub const ConnectivityFilter = struct {
    /// A list of fleet indexing APIs for which to enable socket information
    /// retrieval. Currently, the only supported value is
    /// `GET_THING_CONNECTIVITY_DATA`.
    include_socket_information: ?[]const FleetIndexingApi = null,

    pub const json_field_names = .{
        .include_socket_information = "includeSocketInformation",
    };
};
