/// Describes the image import source.
pub const ImageSourceIdentifier = union(enum) {
    /// The identifier of the EC2 image.
    ec_2_image_id: ?[]const u8,
    /// The EC2 import task ID to import the image from the Amazon EC2 VM import
    /// process.
    ec_2_import_task_id: ?[]const u8,
    /// The ARN of the EC2 Image Builder image.
    image_build_version_arn: ?[]const u8,

    pub const json_field_names = .{
        .ec_2_image_id = "Ec2ImageId",
        .ec_2_import_task_id = "Ec2ImportTaskId",
        .image_build_version_arn = "ImageBuildVersionArn",
    };
};
