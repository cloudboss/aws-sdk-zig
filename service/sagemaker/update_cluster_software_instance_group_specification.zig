/// The configuration that describes specifications of the instance groups to
/// update.
pub const UpdateClusterSoftwareInstanceGroupSpecification = struct {
    /// The version of the HyperPod-managed AMI to update to for the instance group.
    /// Uses semantic versioning in the format `MAJOR.MINOR.PATCH`.
    image_release_version: ?[]const u8 = null,

    /// The name of the instance group to update.
    instance_group_name: []const u8,

    pub const json_field_names = .{
        .image_release_version = "ImageReleaseVersion",
        .instance_group_name = "InstanceGroupName",
    };
};
