pub const AssignmentStatus = enum {
    enabled,
    draft,
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .draft = "DRAFT",
        .disabled = "DISABLED",
    };
};
