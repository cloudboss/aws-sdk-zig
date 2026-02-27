pub const ActionType = enum {
    evidence_collection,
    investigation_analysis,
    summarization,

    pub const json_field_names = .{
        .evidence_collection = "EVIDENCE_COLLECTION",
        .investigation_analysis = "INVESTIGATION_ANALYSIS",
        .summarization = "SUMMARIZATION",
    };
};
