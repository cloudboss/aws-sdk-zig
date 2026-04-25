/// An instance of a threat intelligence detail that constitutes evidence for
/// the finding.
pub const ThreatIntelligenceDetail = struct {
    /// SHA256 of the file that generated the finding.
    threat_file_sha_256: ?[]const u8 = null,

    /// The name of the threat intelligence list that triggered the finding.
    threat_list_name: ?[]const u8 = null,

    /// A list of names of the threats in the threat intelligence list that
    /// triggered the finding.
    threat_names: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .threat_file_sha_256 = "ThreatFileSha256",
        .threat_list_name = "ThreatListName",
        .threat_names = "ThreatNames",
    };
};
