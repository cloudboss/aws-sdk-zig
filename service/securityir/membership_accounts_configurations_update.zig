/// The `MembershipAccountsConfigurationsUpdate`structure represents the
/// configuration updates for member accounts within an Amazon Web Services
/// organization.
///
/// This structure is used to modify existing account configurations and
/// settings for members in the organization. When applying updates, ensure all
/// required fields are properly specified to maintain account consistency.
///
/// Key considerations when using this structure:
///
/// * All configuration changes are validated before being applied
/// * Updates are processed asynchronously in the background
/// * Configuration changes may take several minutes to propagate across all
///   affected accounts
pub const MembershipAccountsConfigurationsUpdate = struct {
    /// The `coverEntireOrganization` field is a boolean value that determines
    /// whether the membership configuration should be applied across the entire
    /// Amazon Web Services Organization.
    ///
    /// When set to `true`, the configuration will be applied to all accounts within
    /// the organization. When set to `false`, the configuration will only apply to
    /// specifically designated accounts.
    cover_entire_organization: ?bool,

    /// A list of organizational unit IDs to add to the membership configuration.
    /// Each organizational unit ID must match the pattern
    /// `ou-[0-9a-z]{4,32}-[a-z0-9]{8,32}`.
    ///
    /// The list must contain between 1 and 5 organizational unit IDs.
    organizational_units_to_add: ?[]const []const u8,

    /// A list of organizational unit IDs to remove from the membership
    /// configuration. Each organizational unit ID must match the pattern
    /// `ou-[0-9a-z]{4,32}-[a-z0-9]{8,32}`.
    ///
    /// The list must contain between 1 and 5 organizational unit IDs per invocation
    /// of the API request.
    organizational_units_to_remove: ?[]const []const u8,

    pub const json_field_names = .{
        .cover_entire_organization = "coverEntireOrganization",
        .organizational_units_to_add = "organizationalUnitsToAdd",
        .organizational_units_to_remove = "organizationalUnitsToRemove",
    };
};
