const AppConfigType = @import("app_config_type.zig").AppConfigType;

/// Configuration settings for an OpenSearch application. For more information,
/// see [Using the
/// OpenSearch user interface in Amazon OpenSearch
/// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/application.html).
pub const AppConfig = struct {
    /// The configuration item to set, such as the admin role for the OpenSearch
    /// application.
    key: ?AppConfigType,

    /// The value assigned to the configuration key, such as an IAM user ARN.
    value: ?[]const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
