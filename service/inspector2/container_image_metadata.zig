/// Contains metadata about a container image associated with a covered
/// resource.
pub const ContainerImageMetadata = struct {
    /// The date and time the container image was pulled.
    image_pulled_at: ?i64 = null,

    /// The tags attached to the container image.
    image_tags: ?[]const []const u8 = null,

    /// The number of times the container image is in use.
    in_use_count: ?i64 = null,

    /// The last time the container image was in use.
    last_in_use_at: ?i64 = null,

    pub const json_field_names = .{
        .image_pulled_at = "imagePulledAt",
        .image_tags = "imageTags",
        .in_use_count = "inUseCount",
        .last_in_use_at = "lastInUseAt",
    };
};
