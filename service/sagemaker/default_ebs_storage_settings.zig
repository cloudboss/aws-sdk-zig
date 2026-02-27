/// A collection of default EBS storage settings that apply to spaces created
/// within a domain or user profile.
pub const DefaultEbsStorageSettings = struct {
    /// The default size of the EBS storage volume for a space.
    default_ebs_volume_size_in_gb: i32,

    /// The maximum size of the EBS storage volume for a space.
    maximum_ebs_volume_size_in_gb: i32,

    pub const json_field_names = .{
        .default_ebs_volume_size_in_gb = "DefaultEbsVolumeSizeInGb",
        .maximum_ebs_volume_size_in_gb = "MaximumEbsVolumeSizeInGb",
    };
};
