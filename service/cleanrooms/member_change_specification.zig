const MemberAbility = @import("member_ability.zig").MemberAbility;

/// Specifies changes to collaboration membership, including adding new members
/// with their abilities and display names.
pub const MemberChangeSpecification = struct {
    /// The Amazon Web Services account ID of the member to add to the
    /// collaboration.
    account_id: []const u8,

    /// Specifies the display name that will be shown for this member in the
    /// collaboration. While this field is required when inviting new members, it
    /// becomes optional when modifying abilities of existing collaboration members.
    display_name: ?[]const u8 = null,

    /// The abilities granted to the collaboration member. These determine what
    /// actions the member can perform within the collaboration.
    ///
    /// The following values are currently not supported: `CAN_QUERY` and
    /// `CAN_RUN_JOB`.
    ///
    /// Set the value of `memberAbilities` to `[]` to allow a member to contribute
    /// data.
    ///
    /// Set the value of `memberAbilities` to `[CAN_RECEIVE_RESULTS]` to allow a
    /// member to contribute data and receive results.
    member_abilities: []const MemberAbility,

    pub const json_field_names = .{
        .account_id = "accountId",
        .display_name = "displayName",
        .member_abilities = "memberAbilities",
    };
};
