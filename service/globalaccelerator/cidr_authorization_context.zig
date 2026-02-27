/// Provides authorization for Amazon to bring a specific IP address range to a
/// specific Amazon Web Services
/// account using bring your own IP addresses (BYOIP).
///
/// For more information, see [Bring your own
/// IP addresses
/// (BYOIP)](https://docs.aws.amazon.com/global-accelerator/latest/dg/using-byoip.html) in the *Global Accelerator Developer Guide*.
pub const CidrAuthorizationContext = struct {
    /// The plain-text authorization message for the prefix and account.
    message: []const u8,

    /// The signed authorization message for the prefix and account.
    signature: []const u8,

    pub const json_field_names = .{
        .message = "Message",
        .signature = "Signature",
    };
};
