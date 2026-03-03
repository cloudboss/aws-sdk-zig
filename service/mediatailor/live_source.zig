const aws = @import("aws");

const HttpPackageConfiguration = @import("http_package_configuration.zig").HttpPackageConfiguration;

/// Live source configuration parameters.
pub const LiveSource = struct {
    /// The ARN for the live source.
    arn: []const u8,

    /// The timestamp that indicates when the live source was created.
    creation_time: ?i64 = null,

    /// The HTTP package configurations for the live source.
    http_package_configurations: []const HttpPackageConfiguration,

    /// The timestamp that indicates when the live source was last modified.
    last_modified_time: ?i64 = null,

    /// The name that's used to refer to a live source.
    live_source_name: []const u8,

    /// The name of the source location.
    source_location_name: []const u8,

    /// The tags assigned to the live source. Tags are key-value pairs that you can
    /// associate with Amazon resources to help with organization, access control,
    /// and cost tracking. For more information, see [Tagging AWS Elemental
    /// MediaTailor
    /// Resources](https://docs.aws.amazon.com/mediatailor/latest/ug/tagging.html).
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .http_package_configurations = "HttpPackageConfigurations",
        .last_modified_time = "LastModifiedTime",
        .live_source_name = "LiveSourceName",
        .source_location_name = "SourceLocationName",
        .tags = "Tags",
    };
};
