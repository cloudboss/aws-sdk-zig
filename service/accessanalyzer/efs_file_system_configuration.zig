/// The proposed access control configuration for an Amazon EFS file system. You
/// can propose a configuration for a new Amazon EFS file system or an existing
/// Amazon EFS file system that you own by specifying the Amazon EFS policy. For
/// more information, see [Using file systems in Amazon
/// EFS](https://docs.aws.amazon.com/efs/latest/ug/using-fs.html).
///
/// * If the configuration is for an existing Amazon EFS file system and you do
///   not specify the Amazon EFS policy, then the access preview uses the
///   existing Amazon EFS policy for the file system.
/// * If the access preview is for a new resource and you do not specify the
///   policy, then the access preview assumes an Amazon EFS file system without
///   a policy.
/// * To propose deletion of an existing Amazon EFS file system policy, you can
///   specify an empty string for the Amazon EFS policy.
pub const EfsFileSystemConfiguration = struct {
    /// The JSON policy definition to apply to the Amazon EFS file system. For more
    /// information on the elements that make up a file system policy, see [Amazon
    /// EFS Resource-based
    /// policies](https://docs.aws.amazon.com/efs/latest/ug/access-control-overview.html#access-control-manage-access-intro-resource-policies).
    file_system_policy: ?[]const u8 = null,

    pub const json_field_names = .{
        .file_system_policy = "fileSystemPolicy",
    };
};
