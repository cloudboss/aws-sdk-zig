pub const HITStatus = enum {
    assignable,
    unassignable,
    reviewable,
    reviewing,
    disposed,

    pub const json_field_names = .{
        .assignable = "Assignable",
        .unassignable = "Unassignable",
        .reviewable = "Reviewable",
        .reviewing = "Reviewing",
        .disposed = "Disposed",
    };
};
