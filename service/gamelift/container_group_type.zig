pub const ContainerGroupType = enum {
    game_server,
    per_instance,

    pub const json_field_names = .{
        .game_server = "GAME_SERVER",
        .per_instance = "PER_INSTANCE",
    };
};
