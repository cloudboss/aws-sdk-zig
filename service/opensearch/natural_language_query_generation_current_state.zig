pub const NaturalLanguageQueryGenerationCurrentState = enum {
    not_enabled,
    enable_complete,
    enable_in_progress,
    enable_failed,
    disable_complete,
    disable_in_progress,
    disable_failed,

    pub const json_field_names = .{
        .not_enabled = "NotEnabled",
        .enable_complete = "EnableComplete",
        .enable_in_progress = "EnableInProgress",
        .enable_failed = "EnableFailed",
        .disable_complete = "DisableComplete",
        .disable_in_progress = "DisableInProgress",
        .disable_failed = "DisableFailed",
    };
};
