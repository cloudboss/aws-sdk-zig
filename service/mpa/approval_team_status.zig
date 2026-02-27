pub const ApprovalTeamStatus = enum {
    active,
    inactive,
    deleting,
    pending,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .inactive = "INACTIVE",
        .deleting = "DELETING",
        .pending = "PENDING",
    };
};
