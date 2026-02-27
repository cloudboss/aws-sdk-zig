const PolicyParameter = @import("policy_parameter.zig").PolicyParameter;

/// HIT Review Policy data structures represent HIT review
/// policies, which you specify when you create a HIT.
pub const ReviewPolicy = struct {
    /// Name of the parameter from the Review policy.
    parameters: ?[]const PolicyParameter,

    /// Name of a Review Policy: SimplePlurality/2011-09-01 or
    /// ScoreMyKnownAnswers/2011-09-01
    policy_name: []const u8,

    pub const json_field_names = .{
        .parameters = "Parameters",
        .policy_name = "PolicyName",
    };
};
