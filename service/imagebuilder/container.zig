/// Details of the container images that are output resources of an image build
/// in a given Amazon Web Services Region: the Region, and the URIs of the
/// container
/// images.
pub const Container = struct {
    /// A list of URIs for containers created in the context Region.
    image_uris: ?[]const []const u8 = null,

    /// Containers and container images are Region-specific. This is the Region
    /// context for
    /// the container.
    region: ?[]const u8 = null,

    pub const json_field_names = .{
        .image_uris = "imageUris",
        .region = "region",
    };
};
