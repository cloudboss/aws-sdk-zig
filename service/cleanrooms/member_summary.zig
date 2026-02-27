const MemberAbility = @import("member_ability.zig").MemberAbility;
const MLMemberAbilities = @import("ml_member_abilities.zig").MLMemberAbilities;
const PaymentConfiguration = @import("payment_configuration.zig").PaymentConfiguration;
const MemberStatus = @import("member_status.zig").MemberStatus;

/// The member object listed by the request.
pub const MemberSummary = struct {
    /// The abilities granted to the collaboration member.
    abilities: []const MemberAbility,

    /// The identifier used to reference members of the collaboration. Currently
    /// only supports Amazon Web Services account ID.
    account_id: []const u8,

    /// The time when the member was created.
    create_time: i64,

    /// The member's display name.
    display_name: []const u8,

    /// The unique ARN for the member's associated membership, if present.
    membership_arn: ?[]const u8,

    /// The unique ID for the member's associated membership, if present.
    membership_id: ?[]const u8,

    /// Provides a summary of the ML abilities for the collaboration member.
    ml_abilities: ?MLMemberAbilities,

    /// The collaboration member's payment responsibilities set by the collaboration
    /// creator.
    payment_configuration: PaymentConfiguration,

    /// The status of the member.
    status: MemberStatus,

    /// The time the member metadata was last updated.
    update_time: i64,

    pub const json_field_names = .{
        .abilities = "abilities",
        .account_id = "accountId",
        .create_time = "createTime",
        .display_name = "displayName",
        .membership_arn = "membershipArn",
        .membership_id = "membershipId",
        .ml_abilities = "mlAbilities",
        .payment_configuration = "paymentConfiguration",
        .status = "status",
        .update_time = "updateTime",
    };
};
