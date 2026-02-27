pub const WorkloadIssueManagementStatus = enum {
    enabled,
    disabled,
    inherit,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
        .inherit = "INHERIT",
    };
};
