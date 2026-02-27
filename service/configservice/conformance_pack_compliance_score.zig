/// A compliance score is the percentage of the number of compliant
/// rule-resource combinations in a conformance pack compared to the number of
/// total possible rule-resource combinations in the conformance pack.
/// This metric provides you with a high-level view of the compliance state of
/// your conformance packs. You can use it to identify, investigate, and
/// understand
/// the level of compliance in your conformance packs.
pub const ConformancePackComplianceScore = struct {
    /// The name of the conformance pack.
    conformance_pack_name: ?[]const u8,

    /// The time that the conformance pack compliance score was last updated.
    last_updated_time: ?i64,

    /// Compliance score for the conformance pack. Conformance packs with no
    /// evaluation results will have a compliance score of `INSUFFICIENT_DATA`.
    score: ?[]const u8,

    pub const json_field_names = .{
        .conformance_pack_name = "ConformancePackName",
        .last_updated_time = "LastUpdatedTime",
        .score = "Score",
    };
};
