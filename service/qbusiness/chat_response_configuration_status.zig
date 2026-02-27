pub const ChatResponseConfigurationStatus = enum {
    creating,
    updating,
    failed,
    active,

    pub const json_field_names = .{
        .creating = "CREATING",
        .updating = "UPDATING",
        .failed = "FAILED",
        .active = "ACTIVE",
    };
};
