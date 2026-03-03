const DataSourceToIndexFieldMapping = @import("data_source_to_index_field_mapping.zig").DataSourceToIndexFieldMapping;
const FsxFileSystemType = @import("fsx_file_system_type.zig").FsxFileSystemType;
const DataSourceVpcConfiguration = @import("data_source_vpc_configuration.zig").DataSourceVpcConfiguration;

/// Provides the configuration information to connect to Amazon FSx as your data
/// source.
///
/// Amazon Kendra now supports an upgraded Amazon FSx Windows connector.
///
/// You must now use the
/// [TemplateConfiguration](https://docs.aws.amazon.com/kendra/latest/APIReference/API_TemplateConfiguration.html) object instead of the
/// `FsxConfiguration` object to configure your connector.
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
pub const FsxConfiguration = struct {
    /// A list of regular expression patterns to exclude certain files in your
    /// Amazon FSx file system. Files that match the patterns are excluded from the
    /// index.
    /// Files that don't match the patterns are included in the index. If a file
    /// matches both an
    /// inclusion and exclusion pattern, the exclusion pattern takes precedence and
    /// the file
    /// isn't included in the index.
    exclusion_patterns: ?[]const []const u8 = null,

    /// A list of `DataSourceToIndexFieldMapping` objects that map Amazon FSx data
    /// source attributes or field names to Amazon Kendra index field names. To
    /// create custom fields, use the `UpdateIndex` API before you map to Amazon FSx
    /// fields. For more information, see [Mapping data source
    /// fields](https://docs.aws.amazon.com/kendra/latest/dg/field-mapping.html).
    /// The
    /// Amazon FSx data source field names must exist in your Amazon FSx
    /// custom metadata.
    field_mappings: ?[]const DataSourceToIndexFieldMapping = null,

    /// The identifier of the Amazon FSx file system.
    ///
    /// You can find your file system ID on the file system dashboard in the Amazon
    /// FSx console. For information on how to create a file system in Amazon FSx
    /// console, using Windows File Server as an example, see [Amazon FSx Getting
    /// started
    /// guide](https://docs.aws.amazon.com/fsx/latest/WindowsGuide/getting-started-step1.html).
    file_system_id: []const u8,

    /// The Amazon FSx file system type. Windows is currently the only supported
    /// type.
    file_system_type: FsxFileSystemType,

    /// A list of regular expression patterns to include certain files in your
    /// Amazon FSx file system. Files that match the patterns are included in the
    /// index.
    /// Files that don't match the patterns are excluded from the index. If a file
    /// matches both
    /// an inclusion and exclusion pattern, the exclusion pattern takes precedence
    /// and the file
    /// isn't included in the index.
    inclusion_patterns: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of an Secrets Manager secret that contains
    /// the
    /// key-value pairs required to connect to your Amazon FSx file system. Windows
    /// is
    /// currently the only supported type. The secret must contain a JSON structure
    /// with the
    /// following keys:
    ///
    /// * username—The Active Directory user name, along with the Domain Name
    /// System (DNS) domain name. For example,
    /// *user@corp.example.com*. The Active Directory user
    /// account must have read and mounting access to the Amazon FSx file system
    /// for Windows.
    ///
    /// * password—The password of the Active Directory user account with read
    /// and mounting access to the Amazon FSx Windows file system.
    secret_arn: ?[]const u8 = null,

    /// Configuration information for an Amazon Virtual Private Cloud to connect to
    /// your Amazon FSx. Your Amazon FSx instance must reside inside your VPC.
    vpc_configuration: DataSourceVpcConfiguration,

    pub const json_field_names = .{
        .exclusion_patterns = "ExclusionPatterns",
        .field_mappings = "FieldMappings",
        .file_system_id = "FileSystemId",
        .file_system_type = "FileSystemType",
        .inclusion_patterns = "InclusionPatterns",
        .secret_arn = "SecretArn",
        .vpc_configuration = "VpcConfiguration",
    };
};
