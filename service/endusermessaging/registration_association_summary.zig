/// Contains summary information about a registration that is associated with a
/// brand profile.
pub const RegistrationAssociationSummary = struct {
    /// The time when the resource was created, in Unix epoch time.
    created_at: i64,

    /// The identifier of the registration.
    registration_id: []const u8,

    /// The type of the registration, for example US_TOLL_FREE_REGISTRATION or
    /// SENDER_ID.
    registration_type: []const u8,

    /// Specifies whether smart matching was used to create the association.
    smart_match_used: bool,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .registration_id = "registrationId",
        .registration_type = "registrationType",
        .smart_match_used = "smartMatchUsed",
    };
};
