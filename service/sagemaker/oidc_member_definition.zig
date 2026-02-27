/// A list of user groups that exist in your OIDC Identity Provider (IdP). One
/// to ten groups can be used to create a single private work team. When you add
/// a user group to the list of `Groups`, you can add that user group to one or
/// more private work teams. If you add a user group to a private work team, all
/// workers in that user group are added to the work team.
pub const OidcMemberDefinition = struct {
    /// A list of comma seperated strings that identifies user groups in your OIDC
    /// IdP. Each user group is made up of a group of private workers.
    groups: ?[]const []const u8,

    pub const json_field_names = .{
        .groups = "Groups",
    };
};
