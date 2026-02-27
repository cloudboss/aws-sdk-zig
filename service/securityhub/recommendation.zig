/// A recommendation on how to remediate the issue identified in a finding.
pub const Recommendation = struct {
    /// Describes the recommended steps to take to remediate an issue identified in
    /// a finding.
    ///
    /// Length Constraints: Minimum of 1 length. Maximum of 512 length.
    text: ?[]const u8,

    /// A URL to a page or site that contains information about how to remediate a
    /// finding.
    url: ?[]const u8,

    pub const json_field_names = .{
        .text = "Text",
        .url = "Url",
    };
};
