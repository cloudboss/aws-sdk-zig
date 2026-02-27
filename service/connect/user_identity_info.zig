/// Contains information about the identity of a user.
///
/// For Amazon Connect instances that are created with the `EXISTING_DIRECTORY`
/// identity management
/// type, `FirstName`, `LastName`, and `Email` cannot be updated from within
/// Amazon Connect because they are managed by the directory.
///
/// The `FirstName` and `LastName` length constraints below apply only to
/// instances using
/// SAML for identity management. If you are using Amazon Connect for identity
/// management, the length constraints
/// are 1-255 for `FirstName`, and 1-256 for `LastName`.
pub const UserIdentityInfo = struct {
    /// The email address. If you are using SAML for identity management and include
    /// this parameter, an error is
    /// returned.
    email: ?[]const u8,

    /// The first name. This is required if you are using Amazon Connect or SAML for
    /// identity management. Inputs
    /// must be in Unicode Normalization Form C (NFC). Text containing characters in
    /// a non-NFC form (for example, decomposed
    /// characters or combining marks) are not accepted.
    first_name: ?[]const u8,

    /// The last name. This is required if you are using Amazon Connect or SAML for
    /// identity management. Inputs must
    /// be in Unicode Normalization Form C (NFC). Text containing characters in a
    /// non-NFC form (for example, decomposed
    /// characters or combining marks) are not accepted.
    last_name: ?[]const u8,

    /// The user's mobile number.
    mobile: ?[]const u8,

    /// The user's secondary email address. If you provide a secondary email, the
    /// user receives email notifications -
    /// other than password reset notifications - to this email address instead of
    /// to their primary email address.
    ///
    /// Pattern: `(?=^.{0,265}$)[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,63}`
    secondary_email: ?[]const u8,

    pub const json_field_names = .{
        .email = "Email",
        .first_name = "FirstName",
        .last_name = "LastName",
        .mobile = "Mobile",
        .secondary_email = "SecondaryEmail",
    };
};
