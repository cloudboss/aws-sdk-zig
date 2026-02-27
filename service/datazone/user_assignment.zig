pub const UserAssignment = enum {
    automatic,
    manual,

    pub const json_field_names = .{
        .automatic = "AUTOMATIC",
        .manual = "MANUAL",
    };
};
