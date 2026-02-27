/// The type of permission a function has to access a resource.
pub const Permission = enum {
    ro,
    rw,

    pub const json_field_names = .{
        .ro = "ro",
        .rw = "rw",
    };
};
