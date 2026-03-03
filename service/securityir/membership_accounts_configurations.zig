/// The `MembershipAccountsConfigurations` structure defines the configuration
/// settings for managing membership accounts withinAmazon Web Services.
///
/// This structure contains settings that determine how member accounts are
/// configured and managed within your organization, including:
///
/// * Account configuration preferences
/// * Membership validation rules
/// * Account access settings
///
/// You can use this structure to define and maintain standardized
/// configurations across multiple member accounts in your organization.
pub const MembershipAccountsConfigurations = struct {
    /// The `coverEntireOrganization` field is a boolean value that determines
    /// whether the membership configuration applies to all accounts within an
    /// Amazon Web Services Organization.
    ///
    /// When set to `true`, the configuration will be applied across all accounts in
    /// the organization. When set to `false`, the configuration will only apply to
    /// specifically designated accounts under the AWS Organizational Units
    /// specificied.
    cover_entire_organization: ?bool = null,

    /// A list of organizational unit IDs that follow the pattern
    /// `ou-[0-9a-z]{4,32}-[a-z0-9]{8,32}`. These IDs represent the organizational
    /// units within an Amazon Web Services Organizations structure that are covered
    /// by the membership.
    ///
    /// Each organizational unit ID in the list must:
    ///
    /// * Begin with the prefix 'ou-'
    /// * Contain between 4 and 32 alphanumeric characters in the first segment
    /// * Contain between 8 and 32 alphanumeric characters in the second segment
    organizational_units: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .cover_entire_organization = "coverEntireOrganization",
        .organizational_units = "organizationalUnits",
    };
};
