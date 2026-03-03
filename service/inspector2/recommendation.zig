/// Details about the recommended course of action to remediate the finding.
pub const Recommendation = struct {
    /// The recommended course of action to remediate the finding.
    text: ?[]const u8 = null,

    /// The URL address to the CVE remediation recommendations.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .text = "text",
        .url = "Url",
    };
};
