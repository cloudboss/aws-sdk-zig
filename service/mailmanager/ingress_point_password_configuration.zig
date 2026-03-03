/// The password configuration of the ingress endpoint resource.
pub const IngressPointPasswordConfiguration = struct {
    /// The previous password expiry timestamp of the ingress endpoint resource.
    previous_smtp_password_expiry_timestamp: ?i64 = null,

    /// The previous password version of the ingress endpoint resource.
    previous_smtp_password_version: ?[]const u8 = null,

    /// The current password expiry timestamp of the ingress endpoint resource.
    smtp_password_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .previous_smtp_password_expiry_timestamp = "PreviousSmtpPasswordExpiryTimestamp",
        .previous_smtp_password_version = "PreviousSmtpPasswordVersion",
        .smtp_password_version = "SmtpPasswordVersion",
    };
};
