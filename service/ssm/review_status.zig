pub const ReviewStatus = enum {
    approved,
    not_reviewed,
    pending,
    rejected,

    pub const json_field_names = .{
        .approved = "APPROVED",
        .not_reviewed = "NOT_REVIEWED",
        .pending = "PENDING",
        .rejected = "REJECTED",
    };
};
