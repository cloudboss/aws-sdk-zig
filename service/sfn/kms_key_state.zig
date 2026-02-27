pub const KmsKeyState = enum {
    disabled,
    pending_deletion,
    pending_import,
    unavailable,
    creating,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .pending_deletion = "PENDING_DELETION",
        .pending_import = "PENDING_IMPORT",
        .unavailable = "UNAVAILABLE",
        .creating = "CREATING",
    };
};
