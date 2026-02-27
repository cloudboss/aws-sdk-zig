/// Summary of a predefined attribute.
pub const PredefinedAttributeSummary = struct {
    /// Last modified region.
    last_modified_region: ?[]const u8,

    /// Last modified time.
    last_modified_time: ?i64,

    /// The name of the predefined attribute.
    name: ?[]const u8,

    pub const json_field_names = .{
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
    };
};
