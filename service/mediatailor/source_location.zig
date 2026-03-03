const aws = @import("aws");

const AccessConfiguration = @import("access_configuration.zig").AccessConfiguration;
const DefaultSegmentDeliveryConfiguration = @import("default_segment_delivery_configuration.zig").DefaultSegmentDeliveryConfiguration;
const HttpConfiguration = @import("http_configuration.zig").HttpConfiguration;
const SegmentDeliveryConfiguration = @import("segment_delivery_configuration.zig").SegmentDeliveryConfiguration;

/// A source location is a container for sources. For more information about
/// source locations, see [Working with source
/// locations](https://docs.aws.amazon.com/mediatailor/latest/ug/channel-assembly-source-locations.html) in the *MediaTailor User Guide*.
pub const SourceLocation = struct {
    /// The access configuration for the source location.
    access_configuration: ?AccessConfiguration = null,

    /// The ARN of the SourceLocation.
    arn: []const u8,

    /// The timestamp that indicates when the source location was created.
    creation_time: ?i64 = null,

    /// The default segment delivery configuration.
    default_segment_delivery_configuration: ?DefaultSegmentDeliveryConfiguration = null,

    /// The HTTP configuration for the source location.
    http_configuration: HttpConfiguration,

    /// The timestamp that indicates when the source location was last modified.
    last_modified_time: ?i64 = null,

    /// The segment delivery configurations for the source location.
    segment_delivery_configurations: ?[]const SegmentDeliveryConfiguration = null,

    /// The name of the source location.
    source_location_name: []const u8,

    /// The tags assigned to the source location. Tags are key-value pairs that you
    /// can associate with Amazon resources to help with organization, access
    /// control, and cost tracking. For more information, see [Tagging AWS Elemental
    /// MediaTailor
    /// Resources](https://docs.aws.amazon.com/mediatailor/latest/ug/tagging.html).
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .access_configuration = "AccessConfiguration",
        .arn = "Arn",
        .creation_time = "CreationTime",
        .default_segment_delivery_configuration = "DefaultSegmentDeliveryConfiguration",
        .http_configuration = "HttpConfiguration",
        .last_modified_time = "LastModifiedTime",
        .segment_delivery_configurations = "SegmentDeliveryConfigurations",
        .source_location_name = "SourceLocationName",
        .tags = "Tags",
    };
};
