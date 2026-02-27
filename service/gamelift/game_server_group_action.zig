pub const GameServerGroupAction = enum {
    replace_instance_types,

    pub const json_field_names = .{
        .replace_instance_types = "REPLACE_INSTANCE_TYPES",
    };
};
