/// Contains details about an organizational unit (OU). An OU is a container of
/// Amazon Web Services
/// accounts within a root of an organization. Policies that are attached to an
/// OU apply to
/// all accounts contained in that OU and in any child OUs.
pub const OrganizationalUnit = struct {
    /// The Amazon Resource Name (ARN) of this OU.
    ///
    /// For more information about ARNs in Organizations, see [ARN
    /// Formats Supported by
    /// Organizations](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsorganizations.html#awsorganizations-resources-for-iam-policies) in the *Amazon Web Services Service Authorization Reference*.
    arn: ?[]const u8 = null,

    /// The unique identifier (ID) associated with this OU. The ID is unique to the
    /// organization only.
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex) for an organizational
    /// unit ID string requires
    /// "ou-" followed by from 4 to 32 lowercase letters or digits (the ID of the
    /// root that contains the
    /// OU). This string is followed by a second "-" dash and from 8 to 32
    /// additional lowercase letters
    /// or digits.
    id: ?[]const u8 = null,

    /// The friendly name of this OU.
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex)
    /// that is used to validate this parameter is a string of any of the characters
    /// in the ASCII
    /// character range.
    name: ?[]const u8 = null,

    /// The path in the organization where this OU exists.
    path: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .name = "Name",
        .path = "Path",
    };
};
