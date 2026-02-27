pub const PropertyKey = enum {
    owner,
    launch_role,

    pub const json_field_names = .{
        .owner = "Owner",
        .launch_role = "LaunchRole",
    };
};
