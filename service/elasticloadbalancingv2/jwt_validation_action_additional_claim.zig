const JwtValidationActionAdditionalClaimFormatEnum = @import("jwt_validation_action_additional_claim_format_enum.zig").JwtValidationActionAdditionalClaimFormatEnum;

/// Information about an additional claim to validate.
pub const JwtValidationActionAdditionalClaim = struct {
    /// The format of the claim value.
    format: JwtValidationActionAdditionalClaimFormatEnum,

    /// The name of the claim. You can't specify `exp`, `iss`,
    /// `nbf`, or `iat` because we validate them by default.
    name: []const u8,

    /// The claim value. The maximum size of the list is 10.
    /// Each value can be up to 256 characters in length.
    /// If the format is `space-separated-values`, the values
    /// can't include spaces.
    values: []const []const u8,
};
