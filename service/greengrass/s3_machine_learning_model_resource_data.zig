const ResourceDownloadOwnerSetting = @import("resource_download_owner_setting.zig").ResourceDownloadOwnerSetting;

/// Attributes that define an Amazon S3 machine learning resource.
pub const S3MachineLearningModelResourceData = struct {
    /// The absolute local path of the resource inside the Lambda environment.
    destination_path: ?[]const u8,

    owner_setting: ?ResourceDownloadOwnerSetting,

    /// The URI of the source model in an S3 bucket. The model package must be in
    /// tar.gz or .zip format.
    s3_uri: ?[]const u8,

    pub const json_field_names = .{
        .destination_path = "DestinationPath",
        .owner_setting = "OwnerSetting",
        .s3_uri = "S3Uri",
    };
};
