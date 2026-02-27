pub const DelegationStatus = enum {
    in_progress,
    under_review,
    complete,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .under_review = "UNDER_REVIEW",
        .complete = "COMPLETE",
    };
};
