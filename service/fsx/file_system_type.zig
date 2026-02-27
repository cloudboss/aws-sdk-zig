/// The type of Amazon FSx file system.
pub const FileSystemType = enum {
    windows,
    lustre,
    ontap,
    openzfs,

    pub const json_field_names = .{
        .windows = "WINDOWS",
        .lustre = "LUSTRE",
        .ontap = "ONTAP",
        .openzfs = "OPENZFS",
    };
};
