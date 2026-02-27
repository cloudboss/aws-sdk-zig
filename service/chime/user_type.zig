pub const UserType = enum {
    private_user,
    shared_device,

    pub const json_field_names = .{
        .private_user = "PrivateUser",
        .shared_device = "SharedDevice",
    };
};
