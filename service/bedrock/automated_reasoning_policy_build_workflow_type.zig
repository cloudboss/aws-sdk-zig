pub const AutomatedReasoningPolicyBuildWorkflowType = enum {
    ingest_content,
    refine_policy,
    import_policy,

    pub const json_field_names = .{
        .ingest_content = "INGEST_CONTENT",
        .refine_policy = "REFINE_POLICY",
        .import_policy = "IMPORT_POLICY",
    };
};
