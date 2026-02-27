/// Describes the database credentials for connecting to a database on an Amazon
/// Redshift cluster.
pub const RedshiftDatabaseCredentials = struct {
    password: []const u8,

    username: []const u8,

    pub const json_field_names = .{
        .password = "Password",
        .username = "Username",
    };
};
