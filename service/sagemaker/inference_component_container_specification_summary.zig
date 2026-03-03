const aws = @import("aws");

const DeployedImage = @import("deployed_image.zig").DeployedImage;

/// Details about the resources that are deployed with this inference component.
pub const InferenceComponentContainerSpecificationSummary = struct {
    /// The Amazon S3 path where the model artifacts are stored.
    artifact_url: ?[]const u8 = null,

    deployed_image: ?DeployedImage = null,

    /// The environment variables to set in the Docker container.
    environment: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .artifact_url = "ArtifactUrl",
        .deployed_image = "DeployedImage",
        .environment = "Environment",
    };
};
