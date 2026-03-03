/// A list of Active Directory users and groups that have special permissions
/// for SMB file
/// shares on the gateway.
pub const SMBLocalGroups = struct {
    /// A list of Active Directory users and groups that have local Gateway Admin
    /// permissions.
    /// Acceptable formats include: `DOMAIN\User1`, `user1`,
    /// `DOMAIN\group1`, and `group1`.
    ///
    /// Gateway Admins can use the Shared Folders Microsoft Management Console
    /// snap-in to
    /// force-close files that are open and locked.
    gateway_admins: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .gateway_admins = "GatewayAdmins",
    };
};
