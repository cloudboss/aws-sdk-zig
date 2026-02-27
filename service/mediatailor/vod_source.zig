const aws = @import("aws");

const HttpPackageConfiguration = @import("http_package_configuration.zig").HttpPackageConfiguration;

/// VOD source configuration parameters.
pub const VodSource = struct {
    /// The ARN for the VOD source.
    arn: []const u8,

    /// The timestamp that indicates when the VOD source was created.
    creation_time: ?i64,

    /// The HTTP package configurations for the VOD source.
    http_package_configurations: []const HttpPackageConfiguration,

    /// The timestamp that indicates when the VOD source was last modified.
    last_modified_time: ?i64,

    /// The name of the source location that the VOD source is associated with.
    source_location_name: []const u8,

    /// The tags assigned to the VOD source. Tags are key-value pairs that you can
    /// associate with Amazon resources to help with organization, access control,
    /// and cost tracking. For more information, see [Tagging AWS Elemental
    /// MediaTailor
    /// Resources](https://docs.aws.amazon.com/mediatailor/latest/ug/tagging.html).
    tags: ?[]const aws.map.StringMapEntry,

    /// The name of the VOD source.
    vod_source_name: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .http_package_configurations = "HttpPackageConfigurations",
        .last_modified_time = "LastModifiedTime",
        .source_location_name = "SourceLocationName",
        .tags = "Tags",
        .vod_source_name = "VodSourceName",
    };
};
