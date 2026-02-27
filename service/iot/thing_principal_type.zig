pub const ThingPrincipalType = enum {
    exclusive_thing,
    non_exclusive_thing,

    pub const json_field_names = .{
        .exclusive_thing = "EXCLUSIVE_THING",
        .non_exclusive_thing = "NON_EXCLUSIVE_THING",
    };
};
