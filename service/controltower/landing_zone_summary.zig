/// Returns a summary of information about a landing zone.
pub const LandingZoneSummary = struct {
    /// The ARN of the landing zone.
    arn: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
    };
};
