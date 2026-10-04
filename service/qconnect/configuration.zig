const ConnectConfiguration = @import("connect_configuration.zig").ConnectConfiguration;

/// The configuration information of the external data source.
pub const Configuration = union(enum) {
    /// The configuration information of the Connect Customer data source.
    connect_configuration: ?ConnectConfiguration,

    pub const json_field_names = .{
        .connect_configuration = "connectConfiguration",
    };
};
