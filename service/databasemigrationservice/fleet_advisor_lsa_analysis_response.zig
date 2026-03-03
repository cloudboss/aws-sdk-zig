/// Describes a large-scale assessment (LSA) analysis run by a Fleet Advisor
/// collector.
pub const FleetAdvisorLsaAnalysisResponse = struct {
    /// The ID of an LSA analysis run by a Fleet Advisor collector.
    lsa_analysis_id: ?[]const u8 = null,

    /// The status of an LSA analysis run by a Fleet Advisor collector.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .lsa_analysis_id = "LsaAnalysisId",
        .status = "Status",
    };
};
