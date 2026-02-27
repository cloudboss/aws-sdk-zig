pub const SolutionStatus = enum {
    active,
    inactive,
    draft,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .inactive = "INACTIVE",
        .draft = "DRAFT",
    };
};
