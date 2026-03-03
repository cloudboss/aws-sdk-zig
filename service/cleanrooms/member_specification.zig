const MemberAbility = @import("member_ability.zig").MemberAbility;
const MLMemberAbilities = @import("ml_member_abilities.zig").MLMemberAbilities;
const PaymentConfiguration = @import("payment_configuration.zig").PaymentConfiguration;

/// Basic metadata used to construct a new member.
pub const MemberSpecification = struct {
    /// The identifier used to reference members of the collaboration. Currently
    /// only supports Amazon Web Services account ID.
    account_id: []const u8,

    /// The member's display name.
    display_name: []const u8,

    /// The abilities granted to the collaboration member.
    member_abilities: []const MemberAbility,

    /// The ML abilities granted to the collaboration member.
    ml_member_abilities: ?MLMemberAbilities = null,

    /// The collaboration member's payment responsibilities set by the collaboration
    /// creator.
    ///
    /// If the collaboration creator hasn't speciﬁed anyone as the member paying for
    /// query compute costs, then the member who can query is the default payer.
    payment_configuration: ?PaymentConfiguration = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .display_name = "displayName",
        .member_abilities = "memberAbilities",
        .ml_member_abilities = "mlMemberAbilities",
        .payment_configuration = "paymentConfiguration",
    };
};
