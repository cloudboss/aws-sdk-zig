const AttributeMatchingModel = @import("attribute_matching_model.zig").AttributeMatchingModel;
const MatchPurpose = @import("match_purpose.zig").MatchPurpose;
const Rule = @import("rule.zig").Rule;

/// An object which defines the list of matching rules to run in a matching
/// workflow.
pub const RuleBasedProperties = struct {
    /// The comparison type. You can choose `ONE_TO_ONE` or `MANY_TO_MANY` as the
    /// `attributeMatchingModel`.
    ///
    /// If you choose `ONE_TO_ONE`, the system can only match attributes if the
    /// sub-types are an exact match. For example, for the `Email` attribute type,
    /// the system will only consider it a match if the value of the `Email` field
    /// of Profile A matches the value of the `Email` field of Profile B.
    ///
    /// If you choose `MANY_TO_MANY`, the system can match attributes across the
    /// sub-types of an attribute type. For example, if the value of the `Email`
    /// field of Profile A and the value of `BusinessEmail` field of Profile B
    /// matches, the two profiles are matched on the `Email` attribute type.
    attribute_matching_model: AttributeMatchingModel,

    /// An indicator of whether to generate IDs and index the data or not.
    ///
    /// If you choose `IDENTIFIER_GENERATION`, the process generates IDs and indexes
    /// the data.
    ///
    /// If you choose `INDEXING`, the process indexes the data without generating
    /// IDs.
    match_purpose: ?MatchPurpose = null,

    /// A list of `Rule` objects, each of which have fields `RuleName` and
    /// `MatchingKeys`.
    rules: []const Rule,

    pub const json_field_names = .{
        .attribute_matching_model = "attributeMatchingModel",
        .match_purpose = "matchPurpose",
        .rules = "rules",
    };
};
