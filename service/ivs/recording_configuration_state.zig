pub const RecordingConfigurationState = enum {
    creating,
    create_failed,
    active,

    pub const json_field_names = .{
        .creating = "Creating",
        .create_failed = "CreateFailed",
        .active = "Active",
    };
};
