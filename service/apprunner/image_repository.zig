const ImageConfiguration = @import("image_configuration.zig").ImageConfiguration;
const ImageRepositoryType = @import("image_repository_type.zig").ImageRepositoryType;

/// Describes a source image repository.
pub const ImageRepository = struct {
    /// Configuration for running the identified image.
    image_configuration: ?ImageConfiguration = null,

    /// The identifier of an image.
    ///
    /// For an image in Amazon Elastic Container Registry (Amazon ECR), this is an
    /// image name. For the image name format, see [Pulling an
    /// image](https://docs.aws.amazon.com/AmazonECR/latest/userguide/docker-pull-ecr-image.html) in the *Amazon ECR User Guide*.
    image_identifier: []const u8,

    /// The type of the image repository. This reflects the repository provider and
    /// whether the repository is private or public.
    image_repository_type: ImageRepositoryType,

    pub const json_field_names = .{
        .image_configuration = "ImageConfiguration",
        .image_identifier = "ImageIdentifier",
        .image_repository_type = "ImageRepositoryType",
    };
};
