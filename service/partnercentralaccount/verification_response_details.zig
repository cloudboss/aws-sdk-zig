const BusinessVerificationResponse = @import("business_verification_response.zig").BusinessVerificationResponse;
const RegistrantVerificationResponse = @import("registrant_verification_response.zig").RegistrantVerificationResponse;

/// A union structure containing the response details specific to different
/// types of verification processes, providing type-specific information and
/// results.
pub const VerificationResponseDetails = union(enum) {
    /// The response details from a business verification process, including
    /// verification results and any additional business information discovered.
    business_verification_response: ?BusinessVerificationResponse,
    /// The response details from a registrant verification process, including
    /// verification results and any additional steps required for identity
    /// confirmation.
    registrant_verification_response: ?RegistrantVerificationResponse,

    pub const json_field_names = .{
        .business_verification_response = "BusinessVerificationResponse",
        .registrant_verification_response = "RegistrantVerificationResponse",
    };
};
