pub const ChangeSpecificationType = enum {
    member,
    collaboration,

    pub const json_field_names = .{
        .member = "MEMBER",
        .collaboration = "COLLABORATION",
    };
};
