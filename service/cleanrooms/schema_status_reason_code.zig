pub const SchemaStatusReasonCode = enum {
    analysis_rule_missing,
    analysis_templates_not_configured,
    analysis_providers_not_configured,
    differential_privacy_policy_not_configured,
    id_mapping_table_not_populated,
    collaboration_analysis_rule_not_configured,
    additional_analyses_not_configured,
    result_receivers_not_configured,
    additional_analyses_not_allowed,
    result_receivers_not_allowed,
    analysis_rule_types_not_compatible,

    pub const json_field_names = .{
        .analysis_rule_missing = "ANALYSIS_RULE_MISSING",
        .analysis_templates_not_configured = "ANALYSIS_TEMPLATES_NOT_CONFIGURED",
        .analysis_providers_not_configured = "ANALYSIS_PROVIDERS_NOT_CONFIGURED",
        .differential_privacy_policy_not_configured = "DIFFERENTIAL_PRIVACY_POLICY_NOT_CONFIGURED",
        .id_mapping_table_not_populated = "ID_MAPPING_TABLE_NOT_POPULATED",
        .collaboration_analysis_rule_not_configured = "COLLABORATION_ANALYSIS_RULE_NOT_CONFIGURED",
        .additional_analyses_not_configured = "ADDITIONAL_ANALYSES_NOT_CONFIGURED",
        .result_receivers_not_configured = "RESULT_RECEIVERS_NOT_CONFIGURED",
        .additional_analyses_not_allowed = "ADDITIONAL_ANALYSES_NOT_ALLOWED",
        .result_receivers_not_allowed = "RESULT_RECEIVERS_NOT_ALLOWED",
        .analysis_rule_types_not_compatible = "ANALYSIS_RULE_TYPES_NOT_COMPATIBLE",
    };
};
