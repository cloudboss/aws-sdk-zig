const CacheAttributes = @import("cache_attributes.zig").CacheAttributes;
const EndpointNetworkConfiguration = @import("endpoint_network_configuration.zig").EndpointNetworkConfiguration;
const FileSystemAssociationStatusDetail = @import("file_system_association_status_detail.zig").FileSystemAssociationStatusDetail;
const Tag = @import("tag.zig").Tag;

/// Describes the object returned by `DescribeFileSystemAssociations` that
/// describes a created file system association.
pub const FileSystemAssociationInfo = struct {
    /// The Amazon Resource Name (ARN) of the storage used for the audit logs.
    audit_destination_arn: ?[]const u8,

    cache_attributes: ?CacheAttributes,

    /// Specifies network configuration information for the gateway associated with
    /// the Amazon FSx file system.
    ///
    /// If multiple file systems are associated with this gateway, this parameter's
    /// `IpAddresses` field is required.
    endpoint_network_configuration: ?EndpointNetworkConfiguration,

    /// The Amazon Resource Name (ARN) of the file system association.
    file_system_association_arn: ?[]const u8,

    /// The status of the file system association. Valid Values: `AVAILABLE` |
    /// `CREATING` | `DELETING` | `FORCE_DELETING` |
    /// `UPDATING` | `ERROR`
    file_system_association_status: ?[]const u8,

    /// An array containing the FileSystemAssociationStatusDetail data type, which
    /// provides
    /// detailed information on file system association status.
    file_system_association_status_details: ?[]const FileSystemAssociationStatusDetail,

    gateway_arn: ?[]const u8,

    /// The ARN of the backend Amazon FSx file system used for storing file data.
    /// For
    /// information, see
    /// [FileSystem](https://docs.aws.amazon.com/fsx/latest/APIReference/API_FileSystem.html) in the
    /// *Amazon FSx API Reference*.
    location_arn: ?[]const u8,

    /// A list of up to 50 tags assigned to the SMB file share, sorted
    /// alphabetically by key
    /// name. Each tag is a key-value pair.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .audit_destination_arn = "AuditDestinationARN",
        .cache_attributes = "CacheAttributes",
        .endpoint_network_configuration = "EndpointNetworkConfiguration",
        .file_system_association_arn = "FileSystemAssociationARN",
        .file_system_association_status = "FileSystemAssociationStatus",
        .file_system_association_status_details = "FileSystemAssociationStatusDetails",
        .gateway_arn = "GatewayARN",
        .location_arn = "LocationARN",
        .tags = "Tags",
    };
};
