const AccountLevel = @import("account_level.zig").AccountLevel;
const StorageLensAwsOrg = @import("storage_lens_aws_org.zig").StorageLensAwsOrg;
const StorageLensDataExport = @import("storage_lens_data_export.zig").StorageLensDataExport;
const Exclude = @import("exclude.zig").Exclude;
const StorageLensExpandedPrefixesDataExport = @import("storage_lens_expanded_prefixes_data_export.zig").StorageLensExpandedPrefixesDataExport;
const Include = @import("include.zig").Include;

/// A container for the Amazon S3 Storage Lens configuration.
pub const StorageLensConfiguration = struct {
    /// A container for all the account-level configurations of your S3 Storage Lens
    /// configuration.
    account_level: AccountLevel,

    /// A container for the Amazon Web Services organization for this S3 Storage
    /// Lens configuration.
    aws_org: ?StorageLensAwsOrg,

    /// A container to specify the properties of your S3 Storage Lens metrics export
    /// including, the
    /// destination, schema and format.
    data_export: ?StorageLensDataExport,

    /// A container for what is excluded in this configuration. This container can
    /// only be valid
    /// if there is no `Include` container submitted, and it's not empty.
    exclude: ?Exclude,

    /// A container that configures your S3 Storage Lens expanded prefixes metrics
    /// report.
    expanded_prefixes_data_export: ?StorageLensExpandedPrefixesDataExport,

    /// A container for the Amazon S3 Storage Lens configuration ID.
    id: []const u8,

    /// A container for what is included in this configuration. This container can
    /// only be valid
    /// if there is no `Exclude` container submitted, and it's not empty.
    include: ?Include,

    /// A container for whether the S3 Storage Lens configuration is enabled.
    is_enabled: bool = false,

    /// A container for all prefix delimiters that are used for object keys in this
    /// S3 Storage Lens
    /// configuration. The prefix delimiters determine how S3 Storage Lens counts
    /// prefix depth, by
    /// separating the hierarchical levels in object keys.
    ///
    /// * If either a prefix delimiter or existing delimiter is undefined, Amazon S3
    ///   uses the
    /// delimiter that’s defined.
    ///
    /// * If both the prefix delimiter and existing delimiter are undefined, S3 uses
    ///   `/`
    /// as the default delimiter.
    ///
    /// * When custom delimiters are used, both the prefix delimiter and existing
    /// delimiter must specify the same special character. Otherwise, your request
    /// results
    /// in an error.
    prefix_delimiter: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the S3 Storage Lens configuration. This
    /// property is read-only
    /// and follows the following format: `
    /// arn:aws:s3:*us-east-1*:*example-account-id*:storage-lens/*your-dashboard-name*
    /// `
    storage_lens_arn: ?[]const u8,
};
