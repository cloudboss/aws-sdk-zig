const MulticastSourceUpdateRequest = @import("multicast_source_update_request.zig").MulticastSourceUpdateRequest;

/// Settings for a Multicast input. Contains a list of multicast Urls and
/// optional source ip addresses.
pub const MulticastSettingsUpdateRequest = struct {
    sources: ?[]const MulticastSourceUpdateRequest,

    pub const json_field_names = .{
        .sources = "Sources",
    };
};
