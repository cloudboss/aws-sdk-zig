const ConsolidatedPolicyV1 = @import("consolidated_policy_v1.zig").ConsolidatedPolicyV1;

/// Controls on the analysis specifications that can be run on a configured
/// table.
pub const ConsolidatedPolicy = union(enum) {
    /// The consolidated policy version 1.
    v_1: ?ConsolidatedPolicyV1,

    pub const json_field_names = .{
        .v_1 = "v1",
    };
};
