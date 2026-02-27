pub const UserStatusType = enum {
    unconfirmed,
    confirmed,
    archived,
    compromised,
    unknown,
    reset_required,
    force_change_password,
    external_provider,

    pub const json_field_names = .{
        .unconfirmed = "UNCONFIRMED",
        .confirmed = "CONFIRMED",
        .archived = "ARCHIVED",
        .compromised = "COMPROMISED",
        .unknown = "UNKNOWN",
        .reset_required = "RESET_REQUIRED",
        .force_change_password = "FORCE_CHANGE_PASSWORD",
        .external_provider = "EXTERNAL_PROVIDER",
    };
};
