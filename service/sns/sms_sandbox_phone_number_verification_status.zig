/// Enum listing out all supported destination phone number verification
/// statuses. The following enum values are
/// supported.
/// 1. PENDING : The destination phone number is pending verification.
/// 2. VERIFIED : The destination phone number is verified.
pub const SMSSandboxPhoneNumberVerificationStatus = enum {
    pending,
    verified,
};
