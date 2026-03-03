const DataSourceParameters = @import("data_source_parameters.zig").DataSourceParameters;

/// The combination of user name and password that are used as credentials.
pub const CredentialPair = struct {
    /// A set of alternate data source parameters that you want to share for these
    /// credentials. The credentials are applied in tandem with the data source
    /// parameters when
    /// you copy a data source by using a create or update request. The API
    /// operation compares
    /// the `DataSourceParameters` structure that's in the request with the
    /// structures in the `AlternateDataSourceParameters` allow list. If the
    /// structures are an exact match, the request is allowed to use the new data
    /// source with
    /// the existing credentials. If the `AlternateDataSourceParameters` list is
    /// null, the `DataSourceParameters` originally used with these
    /// `Credentials` is automatically allowed.
    alternate_data_source_parameters: ?[]const DataSourceParameters = null,

    /// Password.
    password: []const u8,

    /// User name.
    username: []const u8,

    pub const json_field_names = .{
        .alternate_data_source_parameters = "AlternateDataSourceParameters",
        .password = "Password",
        .username = "Username",
    };
};
