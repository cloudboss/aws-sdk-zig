pub const JobType = enum {
    profile,
    recipe,

    pub const json_field_names = .{
        .profile = "PROFILE",
        .recipe = "RECIPE",
    };
};
