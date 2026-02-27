/// Contains the response information from a registrant verification process,
/// including any verification-specific data and next steps for the individual
/// verification workflow.
pub const RegistrantVerificationResponse = struct {
    /// A secure URL where the registrant can complete additional verification
    /// steps, such as document upload or identity confirmation through a
    /// third-party verification service.
    completion_url: []const u8,

    /// The timestamp when the completion URL expires and is no longer valid for
    /// accessing the verification workflow.
    completion_url_expires_at: i64,

    pub const json_field_names = .{
        .completion_url = "CompletionUrl",
        .completion_url_expires_at = "CompletionUrlExpiresAt",
    };
};
