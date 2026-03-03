const aws = @import("aws");

/// A list of container definitions that describe the different containers that
/// make up an AutoML candidate. For more information, see [
/// ContainerDefinition](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_ContainerDefinition.html).
pub const AutoMLContainerDefinition = struct {
    /// The environment variables to set in the container. For more information, see
    /// [
    /// ContainerDefinition](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_ContainerDefinition.html).
    environment: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Elastic Container Registry (Amazon ECR) path of the container.
    /// For more information, see [
    /// ContainerDefinition](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_ContainerDefinition.html).
    image: []const u8,

    /// The location of the model artifacts. For more information, see [
    /// ContainerDefinition](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_ContainerDefinition.html).
    model_data_url: []const u8,

    pub const json_field_names = .{
        .environment = "Environment",
        .image = "Image",
        .model_data_url = "ModelDataUrl",
    };
};
