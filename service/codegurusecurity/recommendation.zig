/// Information about the recommended course of action to remediate a finding.
pub const Recommendation = struct {
    /// The recommended course of action to remediate the finding.
    text: ?[]const u8,

    /// The URL address to the recommendation for remediating the finding.
    url: ?[]const u8,

    pub const json_field_names = .{
        .text = "text",
        .url = "url",
    };
};
