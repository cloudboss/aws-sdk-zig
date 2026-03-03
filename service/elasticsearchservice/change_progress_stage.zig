/// A progress stage details of a specific domain configuration change.
pub const ChangeProgressStage = struct {
    /// The description of the progress stage.
    description: ?[]const u8 = null,

    /// The last updated timestamp of the progress stage.
    last_updated: ?i64 = null,

    /// The name of the specific progress stage.
    name: ?[]const u8 = null,

    /// The overall status of a specific progress stage.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .last_updated = "LastUpdated",
        .name = "Name",
        .status = "Status",
    };
};
