/// The image configuration.
pub const ImageConfigurationInput = struct {
    /// The URI of an image in the Amazon ECR registry. This field is required when
    /// you create a new application. If you leave this field blank in an update,
    /// Amazon EMR will remove the image configuration.
    image_uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .image_uri = "imageUri",
    };
};
