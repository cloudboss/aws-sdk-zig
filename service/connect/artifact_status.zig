pub const ArtifactStatus = enum {
    approved,
    rejected,
    in_progress,

    pub const json_field_names = .{
        .approved = "APPROVED",
        .rejected = "REJECTED",
        .in_progress = "IN_PROGRESS",
    };
};
