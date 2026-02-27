pub const DataProtectionStatus = enum {
    activated,
    deleted,
    archived,
    disabled,

    pub const json_field_names = .{
        .activated = "ACTIVATED",
        .deleted = "DELETED",
        .archived = "ARCHIVED",
        .disabled = "DISABLED",
    };
};
