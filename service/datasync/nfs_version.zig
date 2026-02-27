pub const NfsVersion = enum {
    automatic,
    nfs3,
    nfs4_0,
    nfs4_1,

    pub const json_field_names = .{
        .automatic = "AUTOMATIC",
        .nfs3 = "NFS3",
        .nfs4_0 = "NFS4_0",
        .nfs4_1 = "NFS4_1",
    };
};
