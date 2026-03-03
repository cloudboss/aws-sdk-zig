const DataSourceName = @import("data_source_name.zig").DataSourceName;
const FeatureStatus = @import("feature_status.zig").FeatureStatus;

/// The Amazon SageMaker Canvas application setting where you configure OAuth
/// for connecting to an external data source, such as Snowflake.
pub const IdentityProviderOAuthSetting = struct {
    /// The name of the data source that you're connecting to. Canvas currently
    /// supports OAuth for Snowflake and Salesforce Data Cloud.
    data_source_name: ?DataSourceName = null,

    /// The ARN of an Amazon Web Services Secrets Manager secret that stores the
    /// credentials from your identity provider, such as the client ID and secret,
    /// authorization URL, and token URL.
    secret_arn: ?[]const u8 = null,

    /// Describes whether OAuth for a data source is enabled or disabled in the
    /// Canvas application.
    status: ?FeatureStatus = null,

    pub const json_field_names = .{
        .data_source_name = "DataSourceName",
        .secret_arn = "SecretArn",
        .status = "Status",
    };
};
