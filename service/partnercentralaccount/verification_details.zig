const BusinessVerificationDetails = @import("business_verification_details.zig").BusinessVerificationDetails;
const RegistrantVerificationDetails = @import("registrant_verification_details.zig").RegistrantVerificationDetails;

/// A union structure containing the specific details required for different
/// types of verification processes supported by AWS Partner Central.
pub const VerificationDetails = union(enum) {
    /// The business verification details to be used when starting a business
    /// verification process.
    business_verification_details: ?BusinessVerificationDetails,
    /// The registrant verification details to be used when starting an individual
    /// identity verification process.
    registrant_verification_details: ?RegistrantVerificationDetails,

    pub const json_field_names = .{
        .business_verification_details = "BusinessVerificationDetails",
        .registrant_verification_details = "RegistrantVerificationDetails",
    };
};
