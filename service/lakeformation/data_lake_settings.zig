const aws = @import("aws");

const PrincipalPermissions = @import("principal_permissions.zig").PrincipalPermissions;
const DataLakePrincipal = @import("data_lake_principal.zig").DataLakePrincipal;

/// A structure representing a list of Lake Formation principals designated as
/// data lake administrators and lists of principal permission entries for
/// default create database and default create table permissions.
pub const DataLakeSettings = struct {
    /// Whether to allow Amazon EMR clusters to access data managed by Lake
    /// Formation.
    ///
    /// If true, you allow Amazon EMR clusters to access data in Amazon S3 locations
    /// that are registered with Lake Formation.
    ///
    /// If false or null, no Amazon EMR clusters will be able to access data in
    /// Amazon S3 locations that are registered with Lake Formation.
    ///
    /// For more information, see [(Optional) Allow external data
    /// filtering](https://docs.aws.amazon.com/lake-formation/latest/dg/initial-LF-setup.html#external-data-filter).
    allow_external_data_filtering: ?bool,

    /// Whether to allow a third-party query engine to get data access credentials
    /// without session tags when a caller has full data access permissions.
    allow_full_table_external_data_access: ?bool,

    /// Lake Formation relies on a privileged process secured by Amazon EMR or the
    /// third party integrator to tag the user's role while assuming it. Lake
    /// Formation will publish the acceptable key-value pair, for example key =
    /// "LakeFormationTrustedCaller" and value = "TRUE" and the third party
    /// integrator must properly tag the temporary security credentials that will be
    /// used to call Lake Formation's administrative APIs.
    authorized_session_tag_value_list: ?[]const []const u8,

    /// Specifies whether access control on newly created database is managed by
    /// Lake Formation permissions or exclusively by IAM permissions.
    ///
    /// A null value indicates access control by Lake Formation permissions. A value
    /// that assigns ALL to IAM_ALLOWED_PRINCIPALS indicates access control by IAM
    /// permissions. This is referred to as the setting "Use only IAM access
    /// control," and is for backward compatibility with the Glue permission model
    /// implemented by IAM permissions.
    ///
    /// The only permitted values are an empty array or an array that contains a
    /// single JSON object that grants ALL to IAM_ALLOWED_PRINCIPALS.
    ///
    /// For more information, see [Changing the Default Security Settings for Your
    /// Data
    /// Lake](https://docs.aws.amazon.com/lake-formation/latest/dg/change-settings.html).
    create_database_default_permissions: ?[]const PrincipalPermissions,

    /// Specifies whether access control on newly created table is managed by Lake
    /// Formation permissions or exclusively by IAM permissions.
    ///
    /// A null value indicates access control by Lake Formation permissions. A value
    /// that assigns ALL to IAM_ALLOWED_PRINCIPALS indicates access control by IAM
    /// permissions. This is referred to as the setting "Use only IAM access
    /// control," and is for backward compatibility with the Glue permission model
    /// implemented by IAM permissions.
    ///
    /// The only permitted values are an empty array or an array that contains a
    /// single JSON object that grants ALL to IAM_ALLOWED_PRINCIPALS.
    ///
    /// For more information, see [Changing the Default Security Settings for Your
    /// Data
    /// Lake](https://docs.aws.amazon.com/lake-formation/latest/dg/change-settings.html).
    create_table_default_permissions: ?[]const PrincipalPermissions,

    /// A list of Lake Formation principals. Supported principals are IAM users or
    /// IAM roles.
    data_lake_admins: ?[]const DataLakePrincipal,

    /// A list of the account IDs of Amazon Web Services accounts with Amazon EMR
    /// clusters that are to perform data filtering.>
    external_data_filtering_allow_list: ?[]const DataLakePrincipal,

    /// A key-value map that provides an additional configuration on your data lake.
    /// CROSS_ACCOUNT_VERSION is the key you can configure in the Parameters field.
    /// Accepted values for the CrossAccountVersion key are 1, 2, 3, and 4.
    parameters: ?[]const aws.map.StringMapEntry,

    /// A list of Lake Formation principals with only view access to the resources,
    /// without the ability to make changes. Supported principals are IAM users or
    /// IAM roles.
    read_only_admins: ?[]const DataLakePrincipal,

    /// A list of the resource-owning account IDs that the caller's account can use
    /// to share their user access details (user ARNs). The user ARNs can be logged
    /// in the resource owner's CloudTrail log.
    ///
    /// You may want to specify this property when you are in a high-trust boundary,
    /// such as the same team or company.
    trusted_resource_owners: ?[]const []const u8,

    pub const json_field_names = .{
        .allow_external_data_filtering = "AllowExternalDataFiltering",
        .allow_full_table_external_data_access = "AllowFullTableExternalDataAccess",
        .authorized_session_tag_value_list = "AuthorizedSessionTagValueList",
        .create_database_default_permissions = "CreateDatabaseDefaultPermissions",
        .create_table_default_permissions = "CreateTableDefaultPermissions",
        .data_lake_admins = "DataLakeAdmins",
        .external_data_filtering_allow_list = "ExternalDataFilteringAllowList",
        .parameters = "Parameters",
        .read_only_admins = "ReadOnlyAdmins",
        .trusted_resource_owners = "TrustedResourceOwners",
    };
};
