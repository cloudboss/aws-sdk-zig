const BusinessVerificationDetails = @import("business_verification_details.zig").BusinessVerificationDetails;

/// Contains the response information and results from a business verification
/// process, including any verification-specific data returned by the
/// verification service.
pub const BusinessVerificationResponse = struct {
    /// The business verification details that were processed and verified,
    /// potentially including additional information discovered during the
    /// verification process.
    business_verification_details: BusinessVerificationDetails,

    pub const json_field_names = .{
        .business_verification_details = "BusinessVerificationDetails",
    };
};
