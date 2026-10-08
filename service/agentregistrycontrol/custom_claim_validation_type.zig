const AuthorizingClaimMatchValueType = @import("authorizing_claim_match_value_type.zig").AuthorizingClaimMatchValueType;
const InboundTokenClaimValueType = @import("inbound_token_claim_value_type.zig").InboundTokenClaimValueType;

/// A validation rule applied to a single claim of an inbound JWT.
pub const CustomClaimValidationType = struct {
    /// The value and match operator used to authorize the claim.
    authorizing_claim_match_value: AuthorizingClaimMatchValueType,

    /// The name of the claim in the inbound token to validate.
    inbound_token_claim_name: []const u8,

    /// The value type of the claim in the inbound token, either a string or an
    /// array of strings.
    inbound_token_claim_value_type: InboundTokenClaimValueType,

    pub const json_field_names = .{
        .authorizing_claim_match_value = "authorizingClaimMatchValue",
        .inbound_token_claim_name = "inboundTokenClaimName",
        .inbound_token_claim_value_type = "inboundTokenClaimValueType",
    };
};
