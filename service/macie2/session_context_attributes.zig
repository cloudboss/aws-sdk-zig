/// Provides information about the context in which temporary security
/// credentials were issued to an entity.
pub const SessionContextAttributes = struct {
    /// The date and time, in UTC and ISO 8601 format, when the credentials were
    /// issued.
    creation_date: ?i64,

    /// Specifies whether the credentials were authenticated with a multi-factor
    /// authentication (MFA) device.
    mfa_authenticated: ?bool,

    pub const json_field_names = .{
        .creation_date = "creationDate",
        .mfa_authenticated = "mfaAuthenticated",
    };
};
