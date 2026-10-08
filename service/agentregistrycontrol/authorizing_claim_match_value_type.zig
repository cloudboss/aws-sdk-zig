const ClaimMatchOperatorType = @import("claim_match_operator_type.zig").ClaimMatchOperatorType;
const ClaimMatchValueType = @import("claim_match_value_type.zig").ClaimMatchValueType;

/// The value and match operator used to authorize a claim during JWT
/// validation.
pub const AuthorizingClaimMatchValueType = struct {
    /// The operator used to compare the claim value against the expected value.
    claim_match_operator: ClaimMatchOperatorType,

    /// The expected value or values that the claim is compared against.
    claim_match_value: ClaimMatchValueType,

    pub const json_field_names = .{
        .claim_match_operator = "claimMatchOperator",
        .claim_match_value = "claimMatchValue",
    };
};
