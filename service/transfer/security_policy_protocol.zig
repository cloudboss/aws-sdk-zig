pub const SecurityPolicyProtocol = enum {
    sftp,
    ftps,

    pub const json_field_names = .{
        .sftp = "SFTP",
        .ftps = "FTPS",
    };
};
