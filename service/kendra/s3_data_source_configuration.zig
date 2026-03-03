const AccessControlListConfiguration = @import("access_control_list_configuration.zig").AccessControlListConfiguration;
const DocumentsMetadataConfiguration = @import("documents_metadata_configuration.zig").DocumentsMetadataConfiguration;

/// Provides the configuration information to connect to an Amazon S3
/// bucket.
///
/// Amazon Kendra now supports an upgraded Amazon S3 connector.
///
/// You must now use the
/// [TemplateConfiguration](https://docs.aws.amazon.com/kendra/latest/APIReference/API_TemplateConfiguration.html) object instead of the
/// `S3DataSourceConfiguration` object to configure your connector.
///
/// Connectors configured using the older console and API architecture will
/// continue to
/// function as configured. However, you won't be able to edit or update them.
/// If you want
/// to edit or update your connector configuration, you must create a new
/// connector.
///
/// We recommended migrating your connector workflow to the upgraded version.
/// Support for
/// connectors configured using the older architecture is scheduled to end by
/// June 2024.
pub const S3DataSourceConfiguration = struct {
    /// Provides the path to the S3 bucket that contains the user context filtering
    /// files for
    /// the data source. For the format of the file, see [Access control for S3 data
    /// sources](https://docs.aws.amazon.com/kendra/latest/dg/s3-acl.html).
    access_control_list_configuration: ?AccessControlListConfiguration = null,

    /// The name of the bucket that contains the documents.
    bucket_name: []const u8,

    documents_metadata_configuration: ?DocumentsMetadataConfiguration = null,

    /// A list of glob patterns (patterns that can expand a wildcard pattern into a
    /// list of
    /// path names that match the given pattern) for certain file names and file
    /// types to exclude
    /// from your index. If a document matches both an inclusion and exclusion
    /// prefix or pattern,
    /// the exclusion prefix takes precendence and the document is not indexed.
    /// Examples of glob
    /// patterns include:
    ///
    /// * */myapp/config/**—All files inside config directory.
    ///
    /// * ***/*.png*—All .png files in all directories.
    ///
    /// * ***/*.{png, ico, md}*—All .png, .ico or .md files in all
    /// directories.
    ///
    /// * */myapp/src/**/*.ts*—All .ts files inside src directory (and all
    /// its subdirectories).
    ///
    /// * ***/!(*.module).ts*—All .ts files but not .module.ts
    ///
    /// * **.png , *.jpg*—All PNG and JPEG image files
    /// in a directory (files with the extensions .png and .jpg).
    ///
    /// * **internal**—All files in a directory that
    /// contain 'internal' in the file name, such as 'internal', 'internal_only',
    /// 'company_internal'.
    ///
    /// * ***/*internal**—All internal-related files in
    /// a directory and its subdirectories.
    ///
    /// For more examples, see [Use of Exclude and
    /// Include
    /// Filters](https://docs.aws.amazon.com/cli/latest/reference/s3/#use-of-exclude-and-include-filters) in the Amazon Web Services CLI Command Reference.
    exclusion_patterns: ?[]const []const u8 = null,

    /// A list of glob patterns (patterns that can expand a wildcard pattern into a
    /// list of
    /// path names that match the given pattern) for certain file names and file
    /// types to include
    /// in your index. If a document matches both an inclusion and exclusion prefix
    /// or pattern,
    /// the exclusion prefix takes precendence and the document is not indexed.
    /// Examples of glob
    /// patterns include:
    ///
    /// * */myapp/config/**—All files inside config directory.
    ///
    /// * ***/*.png*—All .png files in all directories.
    ///
    /// * ***/*.{png, ico, md}*—All .png, .ico or .md files in all
    /// directories.
    ///
    /// * */myapp/src/**/*.ts*—All .ts files inside src directory (and all
    /// its subdirectories).
    ///
    /// * ***/!(*.module).ts*—All .ts files but not .module.ts
    ///
    /// * **.png , *.jpg*—All PNG and JPEG image files
    /// in a directory (files with the extensions .png and .jpg).
    ///
    /// * **internal**—All files in a directory that
    /// contain 'internal' in the file name, such as 'internal', 'internal_only',
    /// 'company_internal'.
    ///
    /// * ***/*internal**—All internal-related files in
    /// a directory and its subdirectories.
    ///
    /// For more examples, see [Use of Exclude and
    /// Include
    /// Filters](https://docs.aws.amazon.com/cli/latest/reference/s3/#use-of-exclude-and-include-filters) in the Amazon Web Services CLI Command Reference.
    inclusion_patterns: ?[]const []const u8 = null,

    /// A list of S3 prefixes for the documents that should be included in the
    /// index.
    inclusion_prefixes: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .access_control_list_configuration = "AccessControlListConfiguration",
        .bucket_name = "BucketName",
        .documents_metadata_configuration = "DocumentsMetadataConfiguration",
        .exclusion_patterns = "ExclusionPatterns",
        .inclusion_patterns = "InclusionPatterns",
        .inclusion_prefixes = "InclusionPrefixes",
    };
};
