const aws = @import("aws");

const AttributeValue = @import("attribute_value.zig").AttributeValue;

/// A user object that contains identifying information and attributes for a
/// specified user.
pub const User = struct {
    /// The [distinguished
    /// name](https://learn.microsoft.com/en-us/windows/win32/ad/object-names-and-identities#distinguished-name) of the object.
    distinguished_name: ?[]const u8 = null,

    /// The email address of the user.
    email_address: ?[]const u8 = null,

    /// Indicates whether the user account is active.
    enabled: ?bool = null,

    /// The first name of the user.
    given_name: ?[]const u8 = null,

    /// An expression that includes one or more attributes, data types, and values
    /// of a
    /// user.
    other_attributes: ?[]const aws.map.MapEntry(AttributeValue) = null,

    /// The name of the user.
    sam_account_name: []const u8,

    /// The unique security identifier (SID) of the user.
    sid: ?[]const u8 = null,

    /// The last name of the user.
    surname: ?[]const u8 = null,

    /// The UPN that is an internet-style login name for a user and based on the
    /// internet
    /// standard [RFC 822](https://datatracker.ietf.org/doc/html/rfc822). The UPN is
    /// shorter
    /// than the distinguished name and easier to remember.
    user_principal_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .distinguished_name = "DistinguishedName",
        .email_address = "EmailAddress",
        .enabled = "Enabled",
        .given_name = "GivenName",
        .other_attributes = "OtherAttributes",
        .sam_account_name = "SAMAccountName",
        .sid = "SID",
        .surname = "Surname",
        .user_principal_name = "UserPrincipalName",
    };
};
