pub const LambdaFilesystemPermission = enum {
    ro,
    rw,

    pub const json_field_names = .{
        .ro = "RO",
        .rw = "RW",
    };
};
