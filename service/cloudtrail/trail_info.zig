/// Information about a CloudTrail trail, including the trail's name, home
/// Region,
/// and Amazon Resource Name (ARN).
pub const TrailInfo = struct {
    /// The Amazon Web Services Region in which a trail was created.
    home_region: ?[]const u8 = null,

    /// The name of a trail.
    name: ?[]const u8 = null,

    /// The ARN of a trail.
    trail_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .home_region = "HomeRegion",
        .name = "Name",
        .trail_arn = "TrailARN",
    };
};
