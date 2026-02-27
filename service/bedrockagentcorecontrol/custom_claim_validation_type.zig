const AuthorizingClaimMatchValueType = @import("authorizing_claim_match_value_type.zig").AuthorizingClaimMatchValueType;
const InboundTokenClaimValueType = @import("inbound_token_claim_value_type.zig").InboundTokenClaimValueType;

/// Defines the name of a custom claim field and rules for finding matches to
/// authenticate its value.
pub const CustomClaimValidationType = struct {
    /// Defines the value or values to match for and the relationship of the match.
    authorizing_claim_match_value: AuthorizingClaimMatchValueType,

    /// The name of the custom claim field to check.
    inbound_token_claim_name: []const u8,

    /// The data type of the claim value to check for.
    ///
    /// * Use `STRING` if you want to find an exact match to a string you define.
    /// * Use `STRING_ARRAY` if you want to fnd a match to at least one value in an
    ///   array you define.
    inbound_token_claim_value_type: InboundTokenClaimValueType,

    pub const json_field_names = .{
        .authorizing_claim_match_value = "authorizingClaimMatchValue",
        .inbound_token_claim_name = "inboundTokenClaimName",
        .inbound_token_claim_value_type = "inboundTokenClaimValueType",
    };
};
