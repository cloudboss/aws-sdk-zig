pub const TriggerType = enum {
    backup,
    guardduty,

    pub const json_field_names = .{
        .backup = "BACKUP",
        .guardduty = "GUARDDUTY",
    };
};
