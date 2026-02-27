pub const PermissionType = enum {
    full_access,
    send_as,
    send_on_behalf,

    pub const json_field_names = .{
        .full_access = "FULL_ACCESS",
        .send_as = "SEND_AS",
        .send_on_behalf = "SEND_ON_BEHALF",
    };
};
