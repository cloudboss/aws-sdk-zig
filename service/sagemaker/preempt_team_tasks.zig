pub const PreemptTeamTasks = enum {
    never,
    lowerpriority,

    pub const json_field_names = .{
        .never = "NEVER",
        .lowerpriority = "LOWERPRIORITY",
    };
};
