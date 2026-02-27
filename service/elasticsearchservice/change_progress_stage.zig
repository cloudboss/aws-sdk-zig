/// A progress stage details of a specific domain configuration change.
pub const ChangeProgressStage = struct {
    /// The description of the progress stage.
    description: ?[]const u8,

    /// The last updated timestamp of the progress stage.
    last_updated: ?i64,

    /// The name of the specific progress stage.
    name: ?[]const u8,

    /// The overall status of a specific progress stage.
    status: ?[]const u8,

    pub const json_field_names = .{
        .description = "Description",
        .last_updated = "LastUpdated",
        .name = "Name",
        .status = "Status",
    };
};
