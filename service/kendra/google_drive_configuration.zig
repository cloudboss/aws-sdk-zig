const DataSourceToIndexFieldMapping = @import("data_source_to_index_field_mapping.zig").DataSourceToIndexFieldMapping;

/// Provides the configuration information to connect to Google Drive as your
/// data
/// source.
pub const GoogleDriveConfiguration = struct {
    /// A list of MIME types to exclude from the index. All documents matching the
    /// specified
    /// MIME type are excluded.
    ///
    /// For a list of MIME types, see [Using a
    /// Google Workspace Drive data
    /// source](https://docs.aws.amazon.com/kendra/latest/dg/data-source-google-drive.html).
    exclude_mime_types: ?[]const []const u8 = null,

    /// A list of identifiers or shared drives to exclude from the index. All files
    /// and
    /// folders stored on the shared drive are excluded.
    exclude_shared_drives: ?[]const []const u8 = null,

    /// A list of email addresses of the users. Documents owned by these users are
    /// excluded
    /// from the index. Documents shared with excluded users are indexed unless they
    /// are
    /// excluded in another way.
    exclude_user_accounts: ?[]const []const u8 = null,

    /// A list of regular expression patterns to exclude certain items in your
    /// Google Drive,
    /// including shared drives and users' My Drives. Items that match the patterns
    /// are excluded
    /// from the index. Items that don't match the patterns are included in the
    /// index. If an
    /// item matches both an inclusion and exclusion pattern, the exclusion pattern
    /// takes
    /// precedence and the item isn't included in the index.
    exclusion_patterns: ?[]const []const u8 = null,

    /// Maps Google Drive data source attributes or field names to Amazon Kendra
    /// index
    /// field names. To create custom fields, use the `UpdateIndex` API before you
    /// map to Google Drive fields. For more information, see [Mapping data source
    /// fields](https://docs.aws.amazon.com/kendra/latest/dg/field-mapping.html).
    /// The
    /// Google Drive data source field names must exist in your Google Drive custom
    /// metadata.
    field_mappings: ?[]const DataSourceToIndexFieldMapping = null,

    /// A list of regular expression patterns to include certain items in your
    /// Google Drive,
    /// including shared drives and users' My Drives. Items that match the patterns
    /// are included
    /// in the index. Items that don't match the patterns are excluded from the
    /// index. If an
    /// item matches both an inclusion and exclusion pattern, the exclusion pattern
    /// takes
    /// precedence and the item isn't included in the index.
    inclusion_patterns: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of a Secrets Managersecret that contains the
    /// credentials required to connect to Google Drive. For more information, see
    /// [Using a
    /// Google Workspace Drive data
    /// source](https://docs.aws.amazon.com/kendra/latest/dg/data-source-google-drive.html).
    secret_arn: []const u8,

    pub const json_field_names = .{
        .exclude_mime_types = "ExcludeMimeTypes",
        .exclude_shared_drives = "ExcludeSharedDrives",
        .exclude_user_accounts = "ExcludeUserAccounts",
        .exclusion_patterns = "ExclusionPatterns",
        .field_mappings = "FieldMappings",
        .inclusion_patterns = "InclusionPatterns",
        .secret_arn = "SecretArn",
    };
};
