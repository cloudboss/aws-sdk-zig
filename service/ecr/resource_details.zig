const AwsEcrContainerImageDetails = @import("aws_ecr_container_image_details.zig").AwsEcrContainerImageDetails;

/// Contains details about the resource involved in the finding.
pub const ResourceDetails = struct {
    /// An object that contains details about the Amazon ECR container image
    /// involved in the
    /// finding.
    aws_ecr_container_image: ?AwsEcrContainerImageDetails,

    pub const json_field_names = .{
        .aws_ecr_container_image = "awsEcrContainerImage",
    };
};
