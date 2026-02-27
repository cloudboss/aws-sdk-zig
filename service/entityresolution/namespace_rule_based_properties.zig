const AttributeMatchingModel = @import("attribute_matching_model.zig").AttributeMatchingModel;
const RecordMatchingModel = @import("record_matching_model.zig").RecordMatchingModel;
const IdMappingWorkflowRuleDefinitionType = @import("id_mapping_workflow_rule_definition_type.zig").IdMappingWorkflowRuleDefinitionType;
const Rule = @import("rule.zig").Rule;

/// The rule-based properties of an ID namespace. These properties define how
/// the ID namespace can be used in an ID mapping workflow.
pub const NamespaceRuleBasedProperties = struct {
    /// The comparison type. You can either choose `ONE_TO_ONE` or `MANY_TO_MANY` as
    /// the `attributeMatchingModel`.
    ///
    /// If you choose `ONE_TO_ONE`, the system can only match attributes if the
    /// sub-types are an exact match. For example, for the `Email` attribute type,
    /// the system will only consider it a match if the value of the `Email` field
    /// of Profile A matches the value of the `Email` field of Profile B.
    ///
    /// If you choose `MANY_TO_MANY`, the system can match attributes across the
    /// sub-types of an attribute type. For example, if the value of the `Email`
    /// field of Profile A matches the value of `BusinessEmail` field of Profile B,
    /// the two profiles are matched on the `Email` attribute type.
    attribute_matching_model: ?AttributeMatchingModel,

    /// The type of matching record that is allowed to be used in an ID mapping
    /// workflow.
    ///
    /// If the value is set to `ONE_SOURCE_TO_ONE_TARGET`, only one record in the
    /// source is matched to one record in the target.
    ///
    /// If the value is set to `MANY_SOURCE_TO_ONE_TARGET`, all matching records in
    /// the source are matched to one record in the target.
    record_matching_models: ?[]const RecordMatchingModel,

    /// The sets of rules you can use in an ID mapping workflow. The limitations
    /// specified for the source and target must be compatible.
    rule_definition_types: ?[]const IdMappingWorkflowRuleDefinitionType,

    /// The rules for the ID namespace.
    rules: ?[]const Rule,

    pub const json_field_names = .{
        .attribute_matching_model = "attributeMatchingModel",
        .record_matching_models = "recordMatchingModels",
        .rule_definition_types = "ruleDefinitionTypes",
        .rules = "rules",
    };
};
