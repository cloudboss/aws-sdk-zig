const AssetBundleImportJobDataSourceCredentials = @import("asset_bundle_import_job_data_source_credentials.zig").AssetBundleImportJobDataSourceCredentials;
const DataSourceParameters = @import("data_source_parameters.zig").DataSourceParameters;
const SslProperties = @import("ssl_properties.zig").SslProperties;
const VpcConnectionProperties = @import("vpc_connection_properties.zig").VpcConnectionProperties;

/// The override parameters for a single data source that is being imported.
pub const AssetBundleImportJobDataSourceOverrideParameters = struct {
    /// An optional structure that provides the credentials to be used to create the
    /// imported
    /// data source.
    credentials: ?AssetBundleImportJobDataSourceCredentials,

    /// The ID of the data source to apply overrides to.
    data_source_id: []const u8,

    data_source_parameters: ?DataSourceParameters,

    /// A new name for the data source.
    name: ?[]const u8,

    ssl_properties: ?SslProperties,

    vpc_connection_properties: ?VpcConnectionProperties,

    pub const json_field_names = .{
        .credentials = "Credentials",
        .data_source_id = "DataSourceId",
        .data_source_parameters = "DataSourceParameters",
        .name = "Name",
        .ssl_properties = "SslProperties",
        .vpc_connection_properties = "VpcConnectionProperties",
    };
};
