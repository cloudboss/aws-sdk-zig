/// Progress details for each stage of a domain update.
pub const ChangeProgressStage = struct {
    /// The description of the stage.
    description: ?[]const u8 = null,

    /// The most recent updated timestamp of the stage.
    last_updated: ?i64 = null,

    /// The name of the stage.
    name: ?[]const u8 = null,

    /// The status of the stage.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .last_updated = "LastUpdated",
        .name = "Name",
        .status = "Status",
    };
};
