const ConsolidatedPolicyAggregation = @import("consolidated_policy_aggregation.zig").ConsolidatedPolicyAggregation;
const ConsolidatedPolicyCustom = @import("consolidated_policy_custom.zig").ConsolidatedPolicyCustom;
const ConsolidatedPolicyList = @import("consolidated_policy_list.zig").ConsolidatedPolicyList;

/// Controls on the analysis specifications that can be run on a configured
/// table.
pub const ConsolidatedPolicyV1 = union(enum) {
    /// The aggregation setting for the consolidated policy.
    aggregation: ?ConsolidatedPolicyAggregation,
    /// Custom policy
    custom: ?ConsolidatedPolicyCustom,
    /// The list of consolidated policies.
    list: ?ConsolidatedPolicyList,

    pub const json_field_names = .{
        .aggregation = "aggregation",
        .custom = "custom",
        .list = "list",
    };
};
