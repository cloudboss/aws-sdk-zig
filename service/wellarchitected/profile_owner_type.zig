pub const ProfileOwnerType = enum {
    self,
    shared,

    pub const json_field_names = .{
        .self = "SELF",
        .shared = "SHARED",
    };
};
