pub const StorageVirtualMachineRootVolumeSecurityStyle = enum {
    unix,
    ntfs,
    mixed,

    pub const json_field_names = .{
        .unix = "UNIX",
        .ntfs = "NTFS",
        .mixed = "MIXED",
    };
};
