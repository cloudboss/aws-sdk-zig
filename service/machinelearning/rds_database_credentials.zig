/// The database credentials to connect to a database on an RDS DB instance.
pub const RDSDatabaseCredentials = struct {
    password: []const u8,

    username: []const u8,

    pub const json_field_names = .{
        .password = "Password",
        .username = "Username",
    };
};
