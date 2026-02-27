const MulticastSourceCreateRequest = @import("multicast_source_create_request.zig").MulticastSourceCreateRequest;

/// Settings for a Multicast input. Contains a list of multicast Urls and
/// optional source ip addresses.
pub const MulticastSettingsCreateRequest = struct {
    sources: ?[]const MulticastSourceCreateRequest,

    pub const json_field_names = .{
        .sources = "Sources",
    };
};
