/// An object that contains information about a finding and the scan that
/// generated it.
pub const FindingIdentifier = struct {
    /// The identifier for a finding.
    finding_id: []const u8,

    /// The name of the scan that generated the finding.
    scan_name: []const u8,

    pub const json_field_names = .{
        .finding_id = "findingId",
        .scan_name = "scanName",
    };
};
