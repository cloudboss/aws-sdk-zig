pub const Protocol = enum {
    sftp,
    ftp,
    ftps,
    as2,

    pub const json_field_names = .{
        .sftp = "SFTP",
        .ftp = "FTP",
        .ftps = "FTPS",
        .as2 = "AS2",
    };
};
