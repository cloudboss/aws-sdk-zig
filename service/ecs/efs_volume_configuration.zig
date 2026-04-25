const EFSAuthorizationConfig = @import("efs_authorization_config.zig").EFSAuthorizationConfig;
const EFSTransitEncryption = @import("efs_transit_encryption.zig").EFSTransitEncryption;

/// This parameter is specified when you're using an Amazon Elastic File System
/// file system for task storage. For more information, see [Amazon EFS
/// volumes](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/efs-volumes.html) in the *Amazon Elastic Container Service Developer Guide*.
pub const EFSVolumeConfiguration = struct {
    /// The authorization configuration details for the Amazon EFS file system.
    authorization_config: ?EFSAuthorizationConfig = null,

    /// The Amazon EFS file system ID to use.
    file_system_id: []const u8,

    /// The directory within the Amazon EFS file system to mount as the root
    /// directory inside the host. If this parameter is omitted, the root of the
    /// Amazon EFS volume will be used. Specifying `/` will have the same effect as
    /// omitting this parameter.
    ///
    /// If an EFS access point is specified in the `authorizationConfig`, the root
    /// directory parameter must either be omitted or set to `/` which will enforce
    /// the path set on the EFS access point.
    root_directory: ?[]const u8 = null,

    /// Determines whether to use encryption for Amazon EFS data in transit between
    /// the Amazon ECS host and the Amazon EFS server. Transit encryption must be
    /// turned on if Amazon EFS IAM authorization is used. If this parameter is
    /// omitted, the default value of `DISABLED` is used. For more information, see
    /// [Encrypting data in
    /// transit](https://docs.aws.amazon.com/efs/latest/ug/encryption-in-transit.html) in the *Amazon Elastic File System User Guide*.
    transit_encryption: ?EFSTransitEncryption = null,

    /// The port to use when sending encrypted data between the Amazon ECS host and
    /// the Amazon EFS server. If you do not specify a transit encryption port, it
    /// will use the port selection strategy that the Amazon EFS mount helper uses.
    /// For more information, see [EFS mount
    /// helper](https://docs.aws.amazon.com/efs/latest/ug/efs-mount-helper.html) in
    /// the *Amazon Elastic File System User Guide*.
    transit_encryption_port: ?i32 = null,

    pub const json_field_names = .{
        .authorization_config = "authorizationConfig",
        .file_system_id = "fileSystemId",
        .root_directory = "rootDirectory",
        .transit_encryption = "transitEncryption",
        .transit_encryption_port = "transitEncryptionPort",
    };
};
