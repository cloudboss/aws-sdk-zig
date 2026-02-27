pub const AssignmentStatus = enum {
    submitted,
    approved,
    rejected,

    pub const json_field_names = .{
        .submitted = "Submitted",
        .approved = "Approved",
        .rejected = "Rejected",
    };
};
