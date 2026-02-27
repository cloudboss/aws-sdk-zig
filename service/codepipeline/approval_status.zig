pub const ApprovalStatus = enum {
    approved,
    rejected,

    pub const json_field_names = .{
        .approved = "Approved",
        .rejected = "Rejected",
    };
};
