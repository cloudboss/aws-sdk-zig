const EFSAuthorizationConfig = @import("efs_authorization_config.zig").EFSAuthorizationConfig;
const EFSTransitEncryption = @import("efs_transit_encryption.zig").EFSTransitEncryption;

/// This is used when you're using an Amazon Elastic File System file system for
/// job storage. For more
/// information, see [Amazon EFS
/// Volumes](https://docs.aws.amazon.com/batch/latest/userguide/efs-volumes.html) in the *Batch User Guide*.
pub const EFSVolumeConfiguration = struct {
    /// The authorization configuration details for the Amazon EFS file system.
    authorization_config: ?EFSAuthorizationConfig = null,

    /// The Amazon EFS file system ID to use.
    file_system_id: []const u8,

    /// The directory within the Amazon EFS file system to mount as the root
    /// directory inside the host.
    /// If this parameter is omitted, the root of the Amazon EFS volume is used
    /// instead. Specifying
    /// `/` has the same effect as omitting this parameter. The maximum length is
    /// 4,096
    /// characters.
    ///
    /// If an EFS access point is specified in the `authorizationConfig`, the root
    /// directory parameter must either be omitted or set to `/`, which enforces the
    /// path set
    /// on the Amazon EFS access point.
    root_directory: ?[]const u8 = null,

    /// Determines whether to enable encryption for Amazon EFS data in transit
    /// between the Amazon ECS host and
    /// the Amazon EFS server. Transit encryption must be enabled if Amazon EFS IAM
    /// authorization is used. If
    /// this parameter is omitted, the default value of `DISABLED` is used. For more
    /// information, see [Encrypting data in
    /// transit](https://docs.aws.amazon.com/efs/latest/ug/encryption-in-transit.html) in the *Amazon Elastic File System User Guide*.
    transit_encryption: ?EFSTransitEncryption = null,

    /// The port to use when sending encrypted data between the Amazon ECS host and
    /// the Amazon EFS server. If
    /// you don't specify a transit encryption port, it uses the port selection
    /// strategy that the Amazon EFS
    /// mount helper uses. The value must be between 0 and 65,535. For more
    /// information, see [EFS mount
    /// helper](https://docs.aws.amazon.com/efs/latest/ug/efs-mount-helper.html) in
    /// the
    /// *Amazon Elastic File System User Guide*.
    transit_encryption_port: ?i32 = null,

    pub const json_field_names = .{
        .authorization_config = "authorizationConfig",
        .file_system_id = "fileSystemId",
        .root_directory = "rootDirectory",
        .transit_encryption = "transitEncryption",
        .transit_encryption_port = "transitEncryptionPort",
    };
};
