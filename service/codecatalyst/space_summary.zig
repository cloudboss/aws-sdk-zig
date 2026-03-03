/// Information about an space.
pub const SpaceSummary = struct {
    /// The description of the space.
    description: ?[]const u8 = null,

    /// The friendly name of the space displayed to users.
    display_name: ?[]const u8 = null,

    /// The name of the space.
    name: []const u8,

    /// The Amazon Web Services Region
    /// where the space exists.
    region_name: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .display_name = "displayName",
        .name = "name",
        .region_name = "regionName",
    };
};
