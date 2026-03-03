/// The sub-region.
pub const SubRegion = struct {
    /// Abbreviated code for the county or sub-region.
    code: ?[]const u8 = null,

    /// Name for the county or sub-region.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .name = "Name",
    };
};
