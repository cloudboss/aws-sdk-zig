/// The password configuration of the ingress endpoint resource.
pub const IngressPointPasswordConfiguration = struct {
    /// The previous password expiry timestamp of the ingress endpoint resource.
    previous_smtp_password_expiry_timestamp: ?i64,

    /// The previous password version of the ingress endpoint resource.
    previous_smtp_password_version: ?[]const u8,

    /// The current password expiry timestamp of the ingress endpoint resource.
    smtp_password_version: ?[]const u8,

    pub const json_field_names = .{
        .previous_smtp_password_expiry_timestamp = "PreviousSmtpPasswordExpiryTimestamp",
        .previous_smtp_password_version = "PreviousSmtpPasswordVersion",
        .smtp_password_version = "SmtpPasswordVersion",
    };
};
