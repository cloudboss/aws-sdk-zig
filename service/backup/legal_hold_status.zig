pub const LegalHoldStatus = enum {
    creating,
    active,
    canceling,
    canceled,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .canceling = "CANCELING",
        .canceled = "CANCELED",
    };
};
