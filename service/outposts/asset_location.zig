/// Information about the position of the asset in a rack.
pub const AssetLocation = struct {
    /// The position of an asset in a rack measured in rack units.
    rack_elevation: ?f32,

    pub const json_field_names = .{
        .rack_elevation = "RackElevation",
    };
};
