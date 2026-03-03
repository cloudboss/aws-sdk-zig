/// Configuration options for customizing the body content of a template from
/// Meta's library.
pub const LibraryTemplateBodyInputs = struct {
    /// When true, includes a contact number in the template body.
    add_contact_number: ?bool = null,

    /// When true, includes a "learn more" link in the template body.
    add_learn_more_link: ?bool = null,

    /// When true, includes security recommendations in the template body.
    add_security_recommendation: ?bool = null,

    /// When true, includes a package tracking link in the template body.
    add_track_package_link: ?bool = null,

    /// The number of minutes until a verification code or OTP expires.
    code_expiration_minutes: ?i32 = null,

    pub const json_field_names = .{
        .add_contact_number = "addContactNumber",
        .add_learn_more_link = "addLearnMoreLink",
        .add_security_recommendation = "addSecurityRecommendation",
        .add_track_package_link = "addTrackPackageLink",
        .code_expiration_minutes = "codeExpirationMinutes",
    };
};
