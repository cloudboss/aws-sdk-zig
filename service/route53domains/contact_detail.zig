const ContactType = @import("contact_type.zig").ContactType;
const CountryCode = @import("country_code.zig").CountryCode;
const ExtraParam = @import("extra_param.zig").ExtraParam;

/// ContactDetail includes the following elements.
pub const ContactDetail = struct {
    /// First line of the contact's address.
    address_line_1: ?[]const u8,

    /// Second line of contact's address, if any.
    address_line_2: ?[]const u8,

    /// The city of the contact's address.
    city: ?[]const u8,

    /// Indicates whether the contact is a person, company, association, or public
    /// organization. Note the following:
    ///
    /// * If you specify a value other than `PERSON`, you must also specify a
    /// value for `OrganizationName`.
    ///
    /// * For some TLDs, the privacy protection available depends on the value that
    ///   you
    /// specify for `Contact Type`. For the privacy protection settings for
    /// your TLD, see [Domains that You
    /// Can Register with Amazon Route
    /// 53](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/registrar-tld-list.html) in the *Amazon Route 53
    /// Developer Guide*
    ///
    /// * For .es domains, the value of `ContactType` must be
    /// `PERSON` for all three contacts.
    contact_type: ?ContactType,

    /// Code for the country of the contact's address.
    country_code: ?CountryCode,

    /// Email address of the contact.
    email: ?[]const u8,

    /// A list of name-value pairs for parameters required by certain top-level
    /// domains.
    extra_params: ?[]const ExtraParam,

    /// Fax number of the contact.
    ///
    /// Constraints: Phone number must be specified in the format "+[country dialing
    /// code].[number including any area code]". For example, a US phone number
    /// might appear as
    /// `"+1.1234567890"`.
    fax: ?[]const u8,

    /// First name of contact.
    first_name: ?[]const u8,

    /// Last name of contact.
    last_name: ?[]const u8,

    /// Name of the organization for contact types other than `PERSON`.
    organization_name: ?[]const u8,

    /// The phone number of the contact.
    ///
    /// Constraints: Phone number must be specified in the format "+[country dialing
    /// code].[number including any area code>]". For example, a US phone number
    /// might appear
    /// as `"+1.1234567890"`.
    phone_number: ?[]const u8,

    /// The state or province of the contact's city.
    state: ?[]const u8,

    /// The zip or postal code of the contact's address.
    zip_code: ?[]const u8,

    pub const json_field_names = .{
        .address_line_1 = "AddressLine1",
        .address_line_2 = "AddressLine2",
        .city = "City",
        .contact_type = "ContactType",
        .country_code = "CountryCode",
        .email = "Email",
        .extra_params = "ExtraParams",
        .fax = "Fax",
        .first_name = "FirstName",
        .last_name = "LastName",
        .organization_name = "OrganizationName",
        .phone_number = "PhoneNumber",
        .state = "State",
        .zip_code = "ZipCode",
    };
};
