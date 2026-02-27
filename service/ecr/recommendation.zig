/// Details about the recommended course of action to remediate the finding.
pub const Recommendation = struct {
    /// The recommended course of action to remediate the finding.
    text: ?[]const u8,

    /// The URL address to the CVE remediation recommendations.
    url: ?[]const u8,

    pub const json_field_names = .{
        .text = "text",
        .url = "url",
    };
};
