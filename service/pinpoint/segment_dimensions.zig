const aws = @import("aws");

const AttributeDimension = @import("attribute_dimension.zig").AttributeDimension;
const SegmentBehaviors = @import("segment_behaviors.zig").SegmentBehaviors;
const SegmentDemographics = @import("segment_demographics.zig").SegmentDemographics;
const SegmentLocation = @import("segment_location.zig").SegmentLocation;
const MetricDimension = @import("metric_dimension.zig").MetricDimension;

/// Specifies the dimension settings for a segment.
pub const SegmentDimensions = struct {
    /// One or more custom attributes to use as criteria for the segment.
    attributes: ?[]const aws.map.MapEntry(AttributeDimension),

    /// The behavior-based criteria, such as how recently users have used your app,
    /// for the segment.
    behavior: ?SegmentBehaviors,

    /// The demographic-based criteria, such as device platform, for the segment.
    demographic: ?SegmentDemographics,

    /// The location-based criteria, such as region or GPS coordinates, for the
    /// segment.
    location: ?SegmentLocation,

    /// One or more custom metrics to use as criteria for the segment.
    metrics: ?[]const aws.map.MapEntry(MetricDimension),

    /// One or more custom user attributes to use as criteria for the segment.
    user_attributes: ?[]const aws.map.MapEntry(AttributeDimension),

    pub const json_field_names = .{
        .attributes = "Attributes",
        .behavior = "Behavior",
        .demographic = "Demographic",
        .location = "Location",
        .metrics = "Metrics",
        .user_attributes = "UserAttributes",
    };
};
