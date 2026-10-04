/// Summary information about an Oracle Grid Infrastructure (GI) minor version.
pub const GiMinorVersionSummary = struct {
    /// The Grid Infrastructure software image ID for this minor version.
    grid_image_id: ?[]const u8 = null,

    /// The GI minor version.
    version: []const u8,

    pub const json_field_names = .{
        .grid_image_id = "gridImageId",
        .version = "version",
    };
};
