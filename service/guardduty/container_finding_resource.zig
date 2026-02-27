/// Contains information about container resources involved in a GuardDuty
/// finding.
/// This structure provides details about containers that were identified as
/// part of
/// suspicious or malicious activity.
pub const ContainerFindingResource = struct {
    /// The container image information, including the image name and tag used to
    /// run the container
    /// that was involved in the finding.
    image: []const u8,

    /// The unique ID associated with the container image.
    image_uid: ?[]const u8,

    pub const json_field_names = .{
        .image = "Image",
        .image_uid = "ImageUid",
    };
};
