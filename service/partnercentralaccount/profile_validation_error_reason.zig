pub const ProfileValidationErrorReason = enum {
    invalid_content,
    duplicate_profile,
    invalid_logo,
    invalid_logo_url,
    invalid_logo_file,
    invalid_logo_size,
    invalid_website_url,

    pub const json_field_names = .{
        .invalid_content = "INVALID_CONTENT",
        .duplicate_profile = "DUPLICATE_PROFILE",
        .invalid_logo = "INVALID_LOGO",
        .invalid_logo_url = "INVALID_LOGO_URL",
        .invalid_logo_file = "INVALID_LOGO_FILE",
        .invalid_logo_size = "INVALID_LOGO_SIZE",
        .invalid_website_url = "INVALID_WEBSITE_URL",
    };
};
