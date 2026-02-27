/// A collection of EBS storage settings that apply to both private and shared
/// spaces.
pub const EbsStorageSettings = struct {
    /// The size of an EBS storage volume for a space.
    ebs_volume_size_in_gb: i32,

    pub const json_field_names = .{
        .ebs_volume_size_in_gb = "EbsVolumeSizeInGb",
    };
};
