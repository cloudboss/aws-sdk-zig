const RedshiftIAMParameters = @import("redshift_iam_parameters.zig").RedshiftIAMParameters;
const IdentityCenterConfiguration = @import("identity_center_configuration.zig").IdentityCenterConfiguration;

/// The parameters for Amazon Redshift. The `ClusterId` field can be blank if
/// `Host` and `Port` are both set. The `Host` and `Port` fields can be blank if
/// the `ClusterId` field is set.
pub const RedshiftParameters = struct {
    /// Cluster ID. This field can be blank if the `Host` and `Port` are
    /// provided.
    cluster_id: ?[]const u8,

    /// Database.
    database: []const u8,

    /// Host. This field can be blank if `ClusterId` is provided.
    host: ?[]const u8,

    /// An optional parameter that uses IAM authentication to grant Quick Sight
    /// access to your cluster. This parameter can be used instead of
    /// [DataSourceCredentials](https://docs.aws.amazon.com/quicksight/latest/APIReference/API_DataSourceCredentials.html).
    iam_parameters: ?RedshiftIAMParameters,

    /// An optional parameter that configures IAM Identity Center authentication to
    /// grant Quick Sight access to your cluster.
    ///
    /// This parameter can only be specified if your Quick Sight account is
    /// configured with IAM Identity Center.
    identity_center_configuration: ?IdentityCenterConfiguration,

    /// Port. This field can be blank if the `ClusterId` is provided.
    port: i32 = 0,

    pub const json_field_names = .{
        .cluster_id = "ClusterId",
        .database = "Database",
        .host = "Host",
        .iam_parameters = "IAMParameters",
        .identity_center_configuration = "IdentityCenterConfiguration",
        .port = "Port",
    };
};
