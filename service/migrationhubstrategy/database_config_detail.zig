/// Configuration information used for assessing databases.
pub const DatabaseConfigDetail = struct {
    /// AWS Secrets Manager key that holds the credentials that you use to connect
    /// to a database.
    secret_name: ?[]const u8,

    pub const json_field_names = .{
        .secret_name = "secretName",
    };
};
