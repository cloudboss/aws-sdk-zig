const NetworkPathComponentDetails = @import("network_path_component_details.zig").NetworkPathComponentDetails;

/// Details about a network path component that occurs before or after the
/// current
/// component.
pub const NetworkHeader = struct {
    /// Information about the destination of the component.
    destination: ?NetworkPathComponentDetails = null,

    /// The protocol used for the component.
    ///
    /// Length Constraints: Minimum of 1. Maximum of 16.
    protocol: ?[]const u8 = null,

    /// Information about the origin of the component.
    source: ?NetworkPathComponentDetails = null,

    pub const json_field_names = .{
        .destination = "Destination",
        .protocol = "Protocol",
        .source = "Source",
    };
};
