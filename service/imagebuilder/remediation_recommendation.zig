/// Details about the recommended course of action to remediate the finding.
pub const RemediationRecommendation = struct {
    /// The recommended course of action to remediate the finding.
    text: ?[]const u8 = null,

    /// A link to more information about the recommended remediation for this
    /// vulnerability.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .text = "text",
        .url = "url",
    };
};
