/// The email identity type. The identity type can be one of the following:
///
/// * `EMAIL_ADDRESS` – The identity is an email address.
///
/// * `DOMAIN` – The identity is a domain.
pub const IdentityType = enum {
    email_address,
    domain,
    managed_domain,

    pub const json_field_names = .{
        .email_address = "EMAIL_ADDRESS",
        .domain = "DOMAIN",
        .managed_domain = "MANAGED_DOMAIN",
    };
};
