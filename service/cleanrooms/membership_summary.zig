const MemberAbility = @import("member_ability.zig").MemberAbility;
const MLMemberAbilities = @import("ml_member_abilities.zig").MLMemberAbilities;
const MembershipPaymentConfiguration = @import("membership_payment_configuration.zig").MembershipPaymentConfiguration;
const MembershipStatus = @import("membership_status.zig").MembershipStatus;

/// The membership object listed by the request.
pub const MembershipSummary = struct {
    /// The unique ARN for the membership.
    arn: []const u8,

    /// The unique ARN for the membership's associated collaboration.
    collaboration_arn: []const u8,

    /// The identifier of the Amazon Web Services principal that created the
    /// collaboration. Currently only supports Amazon Web Services account ID.
    collaboration_creator_account_id: []const u8,

    /// The display name of the collaboration creator.
    collaboration_creator_display_name: []const u8,

    /// The unique ID for the membership's collaboration.
    collaboration_id: []const u8,

    /// The name for the membership's collaboration.
    collaboration_name: []const u8,

    /// The time when the membership was created.
    create_time: i64,

    /// The unique ID for the membership's collaboration.
    id: []const u8,

    /// The abilities granted to the collaboration member.
    member_abilities: []const MemberAbility,

    /// Provides a summary of the ML abilities for the collaboration member.
    ml_member_abilities: ?MLMemberAbilities = null,

    /// The payment responsibilities accepted by the collaboration member.
    payment_configuration: MembershipPaymentConfiguration,

    /// The status of the membership.
    status: MembershipStatus,

    /// The time the membership metadata was last updated.
    update_time: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .collaboration_arn = "collaborationArn",
        .collaboration_creator_account_id = "collaborationCreatorAccountId",
        .collaboration_creator_display_name = "collaborationCreatorDisplayName",
        .collaboration_id = "collaborationId",
        .collaboration_name = "collaborationName",
        .create_time = "createTime",
        .id = "id",
        .member_abilities = "memberAbilities",
        .ml_member_abilities = "mlMemberAbilities",
        .payment_configuration = "paymentConfiguration",
        .status = "status",
        .update_time = "updateTime",
    };
};
