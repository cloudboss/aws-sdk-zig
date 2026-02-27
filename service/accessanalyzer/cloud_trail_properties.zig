const TrailProperties = @import("trail_properties.zig").TrailProperties;

/// Contains information about CloudTrail access.
pub const CloudTrailProperties = struct {
    /// The end of the time range for which IAM Access Analyzer reviews your
    /// CloudTrail events. Events with a timestamp after this time are not
    /// considered to generate a policy. If this is not included in the request, the
    /// default value is the current time.
    end_time: i64,

    /// The start of the time range for which IAM Access Analyzer reviews your
    /// CloudTrail events. Events with a timestamp before this time are not
    /// considered to generate a policy.
    start_time: i64,

    /// A `TrailProperties` object that contains settings for trail properties.
    trail_properties: []const TrailProperties,

    pub const json_field_names = .{
        .end_time = "endTime",
        .start_time = "startTime",
        .trail_properties = "trailProperties",
    };
};
