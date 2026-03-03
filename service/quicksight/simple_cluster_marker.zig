/// The simple cluster marker of the cluster marker.
pub const SimpleClusterMarker = struct {
    /// The color of the simple cluster marker.
    color: ?[]const u8 = null,

    pub const json_field_names = .{
        .color = "Color",
    };
};
