/// Structure representing one over-the-air (OTA) task configuration.
pub const OtaTaskConfigurationSummary = struct {
    /// The timestamp value of when the over-the-air (OTA) task configuration was
    /// created at.
    created_at: ?i64 = null,

    /// The name of the over-the-air (OTA) task configuration.
    name: ?[]const u8 = null,

    /// The id of the over-the-air (OTA) task configuration
    task_configuration_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .name = "Name",
        .task_configuration_id = "TaskConfigurationId",
    };
};
