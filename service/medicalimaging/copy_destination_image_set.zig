/// Copy the destination image set.
pub const CopyDestinationImageSet = struct {
    /// The image set identifier for the destination image set.
    image_set_id: []const u8,

    /// The latest version identifier for the destination image set.
    latest_version_id: []const u8,

    pub const json_field_names = .{
        .image_set_id = "imageSetId",
        .latest_version_id = "latestVersionId",
    };
};
