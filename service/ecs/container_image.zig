/// The details about the container image a service revision uses.
///
/// To ensure that all tasks in a service use the same container image, Amazon
/// ECS
/// resolves container image names and any image tags specified in the task
/// definition to
/// container image digests.
///
/// After the container image digest has been established, Amazon ECS uses the
/// digest to
/// start any other desired tasks, and for any future service and service
/// revision updates.
/// This leads to all tasks in a service always running identical container
/// images,
/// resulting in version consistency for your software. For more information,
/// see [Container image
/// resolution](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/deployment-type-ecs.html#deployment-container-image-stability) in the Amazon ECS Developer Guide.
pub const ContainerImage = struct {
    /// The name of the container.
    container_name: ?[]const u8 = null,

    /// The container image.
    image: ?[]const u8 = null,

    /// The container image digest.
    image_digest: ?[]const u8 = null,

    pub const json_field_names = .{
        .container_name = "containerName",
        .image = "image",
        .image_digest = "imageDigest",
    };
};
