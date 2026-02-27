/// Gets the Amazon EC2 Container Registry path of the docker image of the model
/// that is hosted in this
/// [ProductionVariant](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_ProductionVariant.html).
///
/// If you used the `registry/repository[:tag]` form to specify the image path
/// of the primary container when you created the model hosted in this
/// `ProductionVariant`, the path resolves to a path of the form
/// `registry/repository[@digest]`. A digest is a hash value that identifies a
/// specific version of an image. For information about Amazon ECR paths, see
/// [Pulling an
/// Image](https://docs.aws.amazon.com/AmazonECR/latest/userguide/docker-pull-ecr-image.html) in the *Amazon ECR User Guide*.
pub const DeployedImage = struct {
    /// The date and time when the image path for the model resolved to the
    /// `ResolvedImage`
    resolution_time: ?i64,

    /// The specific digest path of the image hosted in this `ProductionVariant`.
    resolved_image: ?[]const u8,

    /// The image path you specified when you created the model.
    specified_image: ?[]const u8,

    pub const json_field_names = .{
        .resolution_time = "ResolutionTime",
        .resolved_image = "ResolvedImage",
        .specified_image = "SpecifiedImage",
    };
};
