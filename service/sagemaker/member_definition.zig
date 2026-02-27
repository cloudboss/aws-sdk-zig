const CognitoMemberDefinition = @import("cognito_member_definition.zig").CognitoMemberDefinition;
const OidcMemberDefinition = @import("oidc_member_definition.zig").OidcMemberDefinition;

/// Defines an Amazon Cognito or your own OIDC IdP user group that is part of a
/// work team.
pub const MemberDefinition = struct {
    /// The Amazon Cognito user group that is part of the work team.
    cognito_member_definition: ?CognitoMemberDefinition,

    /// A list user groups that exist in your OIDC Identity Provider (IdP). One to
    /// ten groups can be used to create a single private work team. When you add a
    /// user group to the list of `Groups`, you can add that user group to one or
    /// more private work teams. If you add a user group to a private work team, all
    /// workers in that user group are added to the work team.
    oidc_member_definition: ?OidcMemberDefinition,

    pub const json_field_names = .{
        .cognito_member_definition = "CognitoMemberDefinition",
        .oidc_member_definition = "OidcMemberDefinition",
    };
};
