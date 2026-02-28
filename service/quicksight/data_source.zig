const DataSourceParameters = @import("data_source_parameters.zig").DataSourceParameters;
const DataSourceErrorInfo = @import("data_source_error_info.zig").DataSourceErrorInfo;
const SslProperties = @import("ssl_properties.zig").SslProperties;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;
const DataSourceType = @import("data_source_type.zig").DataSourceType;
const VpcConnectionProperties = @import("vpc_connection_properties.zig").VpcConnectionProperties;

/// The structure of a data source.
pub const DataSource = struct {
    /// A set of alternate data source parameters that you want to share for the
    /// credentials
    /// stored with this data source. The credentials are applied in tandem with the
    /// data source
    /// parameters when you copy a data source by using a create or update request.
    /// The API
    /// operation compares the `DataSourceParameters` structure that's in the
    /// request
    /// with the structures in the `AlternateDataSourceParameters` allow list. If
    /// the
    /// structures are an exact match, the request is allowed to use the credentials
    /// from this
    /// existing data source. If the `AlternateDataSourceParameters` list is null,
    /// the `Credentials` originally used with this `DataSourceParameters`
    /// are automatically allowed.
    alternate_data_source_parameters: ?[]const DataSourceParameters,

    /// The Amazon Resource Name (ARN) of the data source.
    arn: ?[]const u8,

    /// The time that this data source was created.
    created_time: ?i64,

    /// The ID of the data source. This ID is unique per Amazon Web Services Region
    /// for each
    /// Amazon Web Services account.
    data_source_id: ?[]const u8,

    /// The parameters that Quick Sight uses to connect to your underlying source.
    /// This
    /// is a variant type structure. For this structure to be valid, only one of the
    /// attributes
    /// can be non-null.
    data_source_parameters: ?DataSourceParameters,

    /// Error information from the last update or the creation of the data source.
    error_info: ?DataSourceErrorInfo,

    /// The last time that this data source was updated.
    last_updated_time: ?i64,

    /// A display name for the data source.
    name: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the secret associated with the data source
    /// in Amazon Secrets Manager.
    secret_arn: ?[]const u8,

    /// Secure Socket Layer (SSL) properties that apply when Quick Sight connects to
    /// your
    /// underlying source.
    ssl_properties: ?SslProperties,

    /// The HTTP status of the request.
    status: ?ResourceStatus,

    /// The type of the data source. This type indicates which database engine the
    /// data source
    /// connects to.
    @"type": ?DataSourceType,

    /// The VPC connection information. You need to use this parameter only when you
    /// want
    /// Quick Sight to use a VPC connection when connecting to your underlying
    /// source.
    vpc_connection_properties: ?VpcConnectionProperties,

    pub const json_field_names = .{
        .alternate_data_source_parameters = "AlternateDataSourceParameters",
        .arn = "Arn",
        .created_time = "CreatedTime",
        .data_source_id = "DataSourceId",
        .data_source_parameters = "DataSourceParameters",
        .error_info = "ErrorInfo",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .secret_arn = "SecretArn",
        .ssl_properties = "SslProperties",
        .status = "Status",
        .@"type" = "Type",
        .vpc_connection_properties = "VpcConnectionProperties",
    };
};
