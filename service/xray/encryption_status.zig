pub const EncryptionStatus = enum {
    updating,
    active,

    pub const json_field_names = .{
        .updating = "UPDATING",
        .active = "ACTIVE",
    };
};
