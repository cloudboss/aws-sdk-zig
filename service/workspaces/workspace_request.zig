const Tag = @import("tag.zig").Tag;
const WorkspaceProperties = @import("workspace_properties.zig").WorkspaceProperties;

/// Describes the information used to create a WorkSpace.
pub const WorkspaceRequest = struct {
    /// The identifier of the bundle for the WorkSpace. You can use
    /// DescribeWorkspaceBundles to list the available bundles.
    bundle_id: []const u8,

    /// The identifier of the Directory Service directory for the WorkSpace. You can
    /// use DescribeWorkspaceDirectories to list the available directories.
    directory_id: []const u8,

    /// The IPv6 address for the WorkSpace.
    ipv_6_address: ?[]const u8 = null,

    /// Indicates whether the data stored on the root volume is encrypted.
    root_volume_encryption_enabled: ?bool = null,

    /// The tags for the WorkSpace.
    tags: ?[]const Tag = null,

    /// The user name of the user for the WorkSpace. This user name must exist in
    /// the Directory Service directory for the WorkSpace.
    ///
    /// The username is not case-sensitive, but we recommend matching the case in
    /// the Directory Service directory to avoid potential incompatibilities.
    ///
    /// The reserved keyword, `[UNDEFINED]`, is used when creating user-decoupled
    /// WorkSpaces.
    user_name: []const u8,

    /// Indicates whether the data stored on the user volume is encrypted.
    user_volume_encryption_enabled: ?bool = null,

    /// The ARN of the symmetric KMS key used to encrypt data stored on your
    /// WorkSpace.
    /// Amazon WorkSpaces does not support asymmetric KMS keys.
    volume_encryption_key: ?[]const u8 = null,

    /// The name of the user-decoupled WorkSpace.
    ///
    /// `WorkspaceName` is required if `UserName` is
    /// `[UNDEFINED]` for user-decoupled WorkSpaces.
    /// `WorkspaceName` is not applicable if `UserName` is specified
    /// for user-assigned WorkSpaces.
    workspace_name: ?[]const u8 = null,

    /// The WorkSpace properties.
    workspace_properties: ?WorkspaceProperties = null,

    pub const json_field_names = .{
        .bundle_id = "BundleId",
        .directory_id = "DirectoryId",
        .ipv_6_address = "Ipv6Address",
        .root_volume_encryption_enabled = "RootVolumeEncryptionEnabled",
        .tags = "Tags",
        .user_name = "UserName",
        .user_volume_encryption_enabled = "UserVolumeEncryptionEnabled",
        .volume_encryption_key = "VolumeEncryptionKey",
        .workspace_name = "WorkspaceName",
        .workspace_properties = "WorkspaceProperties",
    };
};
