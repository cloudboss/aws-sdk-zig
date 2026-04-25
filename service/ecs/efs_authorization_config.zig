const EFSAuthorizationConfigIAM = @import("efs_authorization_config_iam.zig").EFSAuthorizationConfigIAM;

/// The authorization configuration details for the Amazon EFS file system.
pub const EFSAuthorizationConfig = struct {
    /// The Amazon EFS access point ID to use. If an access point is specified, the
    /// root directory value specified in the `EFSVolumeConfiguration` must either
    /// be omitted or set to `/` which will enforce the path set on the EFS access
    /// point. If an access point is used, transit encryption must be on in the
    /// `EFSVolumeConfiguration`. For more information, see [Working with Amazon EFS
    /// access
    /// points](https://docs.aws.amazon.com/efs/latest/ug/efs-access-points.html) in
    /// the *Amazon Elastic File System User Guide*.
    access_point_id: ?[]const u8 = null,

    /// Determines whether to use the Amazon ECS task role defined in a task
    /// definition when mounting the Amazon EFS file system. If it is turned on,
    /// transit encryption must be turned on in the `EFSVolumeConfiguration`. If
    /// this parameter is omitted, the default value of `DISABLED` is used. For more
    /// information, see [Using Amazon EFS access
    /// points](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/efs-volumes.html#efs-volume-accesspoints) in the *Amazon Elastic Container Service Developer Guide*.
    iam: ?EFSAuthorizationConfigIAM = null,

    pub const json_field_names = .{
        .access_point_id = "accessPointId",
        .iam = "iam",
    };
};
