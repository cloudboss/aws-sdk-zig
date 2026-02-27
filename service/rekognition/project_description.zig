const ProjectAutoUpdate = @import("project_auto_update.zig").ProjectAutoUpdate;
const DatasetMetadata = @import("dataset_metadata.zig").DatasetMetadata;
const CustomizationFeature = @import("customization_feature.zig").CustomizationFeature;
const ProjectStatus = @import("project_status.zig").ProjectStatus;

/// A description of an Amazon Rekognition Custom Labels project. For more
/// information, see DescribeProjects.
pub const ProjectDescription = struct {
    /// Indicates whether automatic retraining will be attempted for the versions of
    /// the project. Applies only to adapters.
    auto_update: ?ProjectAutoUpdate,

    /// The Unix timestamp for the date and time that the project was created.
    creation_timestamp: ?i64,

    /// Information about the training and test datasets in the project.
    datasets: ?[]const DatasetMetadata,

    /// Specifies the project that is being customized.
    feature: ?CustomizationFeature,

    /// The Amazon Resource Name (ARN) of the project.
    project_arn: ?[]const u8,

    /// The current status of the project.
    status: ?ProjectStatus,

    pub const json_field_names = .{
        .auto_update = "AutoUpdate",
        .creation_timestamp = "CreationTimestamp",
        .datasets = "Datasets",
        .feature = "Feature",
        .project_arn = "ProjectArn",
        .status = "Status",
    };
};
