/// The type of the file share.
pub const FileShareType = enum {
    nfs,
    smb,

    pub const json_field_names = .{
        .nfs = "NFS",
        .smb = "SMB",
    };
};
