pub const ImageActionType = enum {
    expire,
    transition,

    pub const json_field_names = .{
        .expire = "EXPIRE",
        .transition = "TRANSITION",
    };
};
