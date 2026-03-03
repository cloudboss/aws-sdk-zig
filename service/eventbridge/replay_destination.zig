/// A `ReplayDestination` object that contains details about a replay.
pub const ReplayDestination = struct {
    /// The ARN of the event bus to replay event to. You can replay events only to
    /// the event bus
    /// specified to create the archive.
    arn: []const u8,

    /// A list of ARNs for rules to replay events to.
    filter_arns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .filter_arns = "FilterArns",
    };
};
