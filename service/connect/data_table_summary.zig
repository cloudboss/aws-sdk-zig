/// A data table summary.
pub const DataTableSummary = struct {
    /// The summary's ARN.
    arn: ?[]const u8,

    /// The summary's ID.
    id: ?[]const u8,

    /// The summary's last modified region.
    last_modified_region: ?[]const u8,

    /// The summary's last modified time.
    last_modified_time: ?i64,

    /// The summary's name.
    name: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
    };
};
