pub const AwsEcsTaskDefinitionVolumesEfsVolumeConfigurationAuthorizationConfigDetails = struct {
    /// The Amazon EFS access point identifier to use.
    access_point_id: ?[]const u8 = null,

    /// Whether to use the Amazon ECS task IAM role defined in a task definition
    /// when mounting the Amazon EFS file system.
    iam: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_point_id = "AccessPointId",
        .iam = "Iam",
    };
};
