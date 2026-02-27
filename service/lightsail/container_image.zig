/// Describes a container image that is registered to an Amazon Lightsail
/// container
/// service.
pub const ContainerImage = struct {
    /// The timestamp when the container image was created.
    created_at: ?i64,

    /// The digest of the container image.
    digest: ?[]const u8,

    /// The name of the container image.
    image: ?[]const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .digest = "digest",
        .image = "image",
    };
};
