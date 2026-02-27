const Trail = @import("trail.zig").Trail;

/// Contains information about CloudTrail access.
pub const CloudTrailDetails = struct {
    /// The ARN of the service role that IAM Access Analyzer uses to access your
    /// CloudTrail trail and service last accessed information.
    access_role: []const u8,

    /// The end of the time range for which IAM Access Analyzer reviews your
    /// CloudTrail events. Events with a timestamp after this time are not
    /// considered to generate a policy. If this is not included in the request, the
    /// default value is the current time.
    end_time: ?i64,

    /// The start of the time range for which IAM Access Analyzer reviews your
    /// CloudTrail events. Events with a timestamp before this time are not
    /// considered to generate a policy.
    start_time: i64,

    /// A `Trail` object that contains settings for a trail.
    trails: []const Trail,

    pub const json_field_names = .{
        .access_role = "accessRole",
        .end_time = "endTime",
        .start_time = "startTime",
        .trails = "trails",
    };
};
