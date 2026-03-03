const DataSourceToIndexFieldMapping = @import("data_source_to_index_field_mapping.zig").DataSourceToIndexFieldMapping;
const OneDriveUsers = @import("one_drive_users.zig").OneDriveUsers;

/// Provides the configuration information to connect to OneDrive as your data
/// source.
pub const OneDriveConfiguration = struct {
    /// `TRUE` to disable local groups information.
    disable_local_groups: bool = false,

    /// A list of regular expression patterns to exclude certain documents in your
    /// OneDrive.
    /// Documents that match the patterns are excluded from the index. Documents
    /// that don't
    /// match the patterns are included in the index. If a document matches both an
    /// inclusion
    /// and exclusion pattern, the exclusion pattern takes precedence and the
    /// document isn't
    /// included in the index.
    ///
    /// The pattern is applied to the file name.
    exclusion_patterns: ?[]const []const u8 = null,

    /// A list of `DataSourceToIndexFieldMapping` objects that map OneDrive data
    /// source attributes or field names to Amazon Kendra index field names. To
    /// create
    /// custom fields, use the `UpdateIndex` API before you map to OneDrive fields.
    /// For more information, see [Mapping data source
    /// fields](https://docs.aws.amazon.com/kendra/latest/dg/field-mapping.html).
    /// The
    /// OneDrive data source field names must exist in your OneDrive custom
    /// metadata.
    field_mappings: ?[]const DataSourceToIndexFieldMapping = null,

    /// A list of regular expression patterns to include certain documents in your
    /// OneDrive.
    /// Documents that match the patterns are included in the index. Documents that
    /// don't match
    /// the patterns are excluded from the index. If a document matches both an
    /// inclusion and
    /// exclusion pattern, the exclusion pattern takes precedence and the document
    /// isn't
    /// included in the index.
    ///
    /// The pattern is applied to the file name.
    inclusion_patterns: ?[]const []const u8 = null,

    /// A list of user accounts whose documents should be indexed.
    one_drive_users: OneDriveUsers,

    /// The Amazon Resource Name (ARN) of an Secrets Managersecret that contains the
    /// user name and password to connect to OneDrive. The user name should be the
    /// application
    /// ID for the OneDrive application, and the password is the application key for
    /// the
    /// OneDrive application.
    secret_arn: []const u8,

    /// The Azure Active Directory domain of the organization.
    tenant_domain: []const u8,

    pub const json_field_names = .{
        .disable_local_groups = "DisableLocalGroups",
        .exclusion_patterns = "ExclusionPatterns",
        .field_mappings = "FieldMappings",
        .inclusion_patterns = "InclusionPatterns",
        .one_drive_users = "OneDriveUsers",
        .secret_arn = "SecretArn",
        .tenant_domain = "TenantDomain",
    };
};
