/// Provides the configuration information that's required to connect to a
/// database.
pub const ConnectionConfiguration = struct {
    /// The name of the host for the database. Can be either a string
    /// (host.subdomain.domain.tld) or an IPv4 or IPv6 address.
    database_host: []const u8,

    /// The name of the database containing the document data.
    database_name: []const u8,

    /// The port that the database uses for connections.
    database_port: i32,

    /// The Amazon Resource Name (ARN) of an Secrets Manager secret that stores
    /// the credentials. The credentials should be a user-password pair. For more
    /// information, see [Using a
    /// Database Data
    /// Source](https://docs.aws.amazon.com/kendra/latest/dg/data-source-database.html). For more information about Secrets Manager, see
    /// [ What
    /// Is Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/intro.html) in the *Secrets Manager*
    /// user guide.
    secret_arn: []const u8,

    /// The name of the table that contains the document data.
    table_name: []const u8,

    pub const json_field_names = .{
        .database_host = "DatabaseHost",
        .database_name = "DatabaseName",
        .database_port = "DatabasePort",
        .secret_arn = "SecretArn",
        .table_name = "TableName",
    };
};
