const AttributeMatchingModel = @import("attribute_matching_model.zig").AttributeMatchingModel;
const RecordMatchingModel = @import("record_matching_model.zig").RecordMatchingModel;
const IdMappingWorkflowRuleDefinitionType = @import("id_mapping_workflow_rule_definition_type.zig").IdMappingWorkflowRuleDefinitionType;
const Rule = @import("rule.zig").Rule;

/// An object that defines the list of matching rules to run in an ID mapping
/// workflow.
pub const IdMappingRuleBasedProperties = struct {
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
    /// field of Profile A matches the value of the `BusinessEmail` field of Profile
    /// B, the two profiles are matched on the `Email` attribute type.
    attribute_matching_model: AttributeMatchingModel,

    /// The type of matching record that is allowed to be used in an ID mapping
    /// workflow.
    ///
    /// If the value is set to `ONE_SOURCE_TO_ONE_TARGET`, only one record in the
    /// source can be matched to the same record in the target.
    ///
    /// If the value is set to `MANY_SOURCE_TO_ONE_TARGET`, multiple records in the
    /// source can be matched to one record in the target.
    record_matching_model: RecordMatchingModel,

    /// The set of rules you can use in an ID mapping workflow. The limitations
    /// specified for the source or target to define the match rules must be
    /// compatible.
    rule_definition_type: IdMappingWorkflowRuleDefinitionType,

    /// The rules that can be used for ID mapping.
    rules: ?[]const Rule = null,

    pub const json_field_names = .{
        .attribute_matching_model = "attributeMatchingModel",
        .record_matching_model = "recordMatchingModel",
        .rule_definition_type = "ruleDefinitionType",
        .rules = "rules",
    };
};
