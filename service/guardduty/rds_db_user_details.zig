/// Contains information about the user and authentication details for a
/// database instance involved in the finding.
pub const RdsDbUserDetails = struct {
    /// The application name used in the anomalous login attempt.
    application: ?[]const u8 = null,

    /// The authentication method used by the user involved in the finding.
    auth_method: ?[]const u8 = null,

    /// The name of the database instance involved in the anomalous login attempt.
    database: ?[]const u8 = null,

    /// The version of the Secure Socket Layer (SSL) used for the network.
    ssl: ?[]const u8 = null,

    /// The user name used in the anomalous login attempt.
    user: ?[]const u8 = null,

    pub const json_field_names = .{
        .application = "Application",
        .auth_method = "AuthMethod",
        .database = "Database",
        .ssl = "Ssl",
        .user = "User",
    };
};
