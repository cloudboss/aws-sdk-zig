pub const TaskFilesystemType = enum {
    ext3,
    ext4,
    xfs,
    ntfs,

    pub const json_field_names = .{
        .ext3 = "EXT3",
        .ext4 = "EXT4",
        .xfs = "XFS",
        .ntfs = "NTFS",
    };
};
