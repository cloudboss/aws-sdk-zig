pub const SmbVersion = enum {
    automatic,
    smb2,
    smb3,
    smb1,
    smb2_0,

    pub const json_field_names = .{
        .automatic = "AUTOMATIC",
        .smb2 = "SMB2",
        .smb3 = "SMB3",
        .smb1 = "SMB1",
        .smb2_0 = "SMB2_0",
    };
};
