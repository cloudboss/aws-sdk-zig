pub const AutomationRulesActionTypeV2 = enum {
    finding_fields_update,
    external_integration,

    pub const json_field_names = .{
        .finding_fields_update = "FINDING_FIELDS_UPDATE",
        .external_integration = "EXTERNAL_INTEGRATION",
    };
};
