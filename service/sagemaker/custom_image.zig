/// A custom SageMaker AI image. For more information, see [Bring your own
/// SageMaker AI
/// image](https://docs.aws.amazon.com/sagemaker/latest/dg/studio-byoi.html).
pub const CustomImage = struct {
    /// The name of the AppImageConfig.
    app_image_config_name: []const u8,

    /// The name of the CustomImage. Must be unique to your account.
    image_name: []const u8,

    /// The version number of the CustomImage.
    image_version_number: ?i32 = null,

    pub const json_field_names = .{
        .app_image_config_name = "AppImageConfigName",
        .image_name = "ImageName",
        .image_version_number = "ImageVersionNumber",
    };
};
