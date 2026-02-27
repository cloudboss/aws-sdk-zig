pub const ComponentDependencyType = enum {
    hard,
    soft,

    pub const json_field_names = .{
        .hard = "HARD",
        .soft = "SOFT",
    };
};
