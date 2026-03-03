const IpPreference = @import("ip_preference.zig").IpPreference;

/// An object that represents the service discovery information for a service
/// mesh.
pub const MeshServiceDiscovery = struct {
    /// The IP version to use to control traffic within the mesh.
    ip_preference: ?IpPreference = null,

    pub const json_field_names = .{
        .ip_preference = "ipPreference",
    };
};
