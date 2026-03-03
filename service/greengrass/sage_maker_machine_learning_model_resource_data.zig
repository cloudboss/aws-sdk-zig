const ResourceDownloadOwnerSetting = @import("resource_download_owner_setting.zig").ResourceDownloadOwnerSetting;

/// Attributes that define an Amazon SageMaker machine learning resource.
pub const SageMakerMachineLearningModelResourceData = struct {
    /// The absolute local path of the resource inside the Lambda environment.
    destination_path: ?[]const u8 = null,

    owner_setting: ?ResourceDownloadOwnerSetting = null,

    /// The ARN of the Amazon SageMaker training job that represents the source
    /// model.
    sage_maker_job_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .destination_path = "DestinationPath",
        .owner_setting = "OwnerSetting",
        .sage_maker_job_arn = "SageMakerJobArn",
    };
};
