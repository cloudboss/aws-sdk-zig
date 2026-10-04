/// The location of a container image.
pub const ImageSource = struct {
    /// The URI of the container image, including the registry, the repository, and
    /// the image tag
    /// or digest. For example,
    /// `111122223333.dkr.ecr.us-east-1.amazonaws.com/my-repository:latest`.
    uri: ?[]const u8 = null,
};
