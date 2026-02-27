/// Provides configuration information for the inference container.
pub const InferenceContainerConfig = struct {
    /// The registry path of the docker image that contains the inference algorithm.
    /// Clean Rooms ML currently only supports the `registry/repository[:tag]` image
    /// path format. For more information about using images in Clean Rooms ML, see
    /// the [Sagemaker API
    /// reference](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_AlgorithmSpecification.html#sagemaker-Type-AlgorithmSpecification-TrainingImage).
    image_uri: []const u8,

    pub const json_field_names = .{
        .image_uri = "imageUri",
    };
};
