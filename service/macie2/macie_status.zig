/// The status of an Amazon Macie account. Valid values are:
pub const MacieStatus = enum {
    paused,
    enabled,

    pub const json_field_names = .{
        .paused = "PAUSED",
        .enabled = "ENABLED",
    };
};
