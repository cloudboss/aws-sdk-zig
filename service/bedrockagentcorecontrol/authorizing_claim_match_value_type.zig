const ClaimMatchOperatorType = @import("claim_match_operator_type.zig").ClaimMatchOperatorType;
const ClaimMatchValueType = @import("claim_match_value_type.zig").ClaimMatchValueType;

/// Defines the value or values to match for and the relationship of the match.
pub const AuthorizingClaimMatchValueType = struct {
    /// Defines the relationship between the claim field value and the value or
    /// values you're matching for.
    claim_match_operator: ClaimMatchOperatorType,

    /// The value or values to match for.
    claim_match_value: ClaimMatchValueType,

    pub const json_field_names = .{
        .claim_match_operator = "claimMatchOperator",
        .claim_match_value = "claimMatchValue",
    };
};
