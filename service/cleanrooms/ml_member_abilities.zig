const CustomMLMemberAbility = @import("custom_ml_member_ability.zig").CustomMLMemberAbility;

/// The ML member abilities for a collaboration member.
pub const MLMemberAbilities = struct {
    /// The custom ML member abilities for a collaboration member.
    custom_ml_member_abilities: []const CustomMLMemberAbility,

    pub const json_field_names = .{
        .custom_ml_member_abilities = "customMLMemberAbilities",
    };
};
