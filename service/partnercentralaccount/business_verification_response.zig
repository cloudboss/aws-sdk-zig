const BusinessVerificationDetails = @import("business_verification_details.zig").BusinessVerificationDetails;

/// Contains the response information and results from a business verification
/// process, including any verification-specific data returned by the
/// verification service.
pub const BusinessVerificationResponse = struct {
    /// The business verification details that were processed and verified,
    /// potentially including additional information discovered during the
    /// verification process.
    business_verification_details: BusinessVerificationDetails,

    /// A secure URL where the registrant can complete additional verification
    /// steps, such as document upload or identity confirmation through a
    /// third-party verification service.
    completion_url: ?[]const u8 = null,

    /// The timestamp when the completion URL expires and is no longer valid for
    /// accessing the verification workflow.
    completion_url_expires_at: ?i64 = null,

    pub const json_field_names = .{
        .business_verification_details = "BusinessVerificationDetails",
        .completion_url = "CompletionUrl",
        .completion_url_expires_at = "CompletionUrlExpiresAt",
    };
};
