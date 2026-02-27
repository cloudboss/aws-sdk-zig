pub const ProgramManagementAccountStatus = enum {
    pending,
    active,
    inactive,

    pub const json_field_names = .{
        .pending = "PENDING",
        .active = "ACTIVE",
        .inactive = "INACTIVE",
    };
};
