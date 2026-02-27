pub const ReviewableHITStatus = enum {
    reviewable,
    reviewing,

    pub const json_field_names = .{
        .reviewable = "Reviewable",
        .reviewing = "Reviewing",
    };
};
