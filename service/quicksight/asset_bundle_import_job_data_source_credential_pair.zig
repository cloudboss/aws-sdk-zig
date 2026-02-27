/// A username and password credential pair to use to import a data source
/// resource.
pub const AssetBundleImportJobDataSourceCredentialPair = struct {
    /// The password for the data source connection.
    password: []const u8,

    /// The username for the data source connection.
    username: []const u8,

    pub const json_field_names = .{
        .password = "Password",
        .username = "Username",
    };
};
