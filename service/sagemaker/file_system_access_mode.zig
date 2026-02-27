pub const FileSystemAccessMode = enum {
    rw,
    ro,

    pub const json_field_names = .{
        .rw = "RW",
        .ro = "RO",
    };
};
