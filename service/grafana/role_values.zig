/// This structure defines which groups defined in the SAML assertion attribute
/// are to be
/// mapped to the Grafana `Admin` and `Editor` roles in the workspace.
/// SAML authenticated users not part of `Admin` or `Editor` role
/// groups have `Viewer` permission over the workspace.
pub const RoleValues = struct {
    /// A list of groups from the SAML assertion attribute to grant the Grafana
    /// `Admin` role to.
    admin: ?[]const []const u8,

    /// A list of groups from the SAML assertion attribute to grant the Grafana
    /// `Editor` role to.
    editor: ?[]const []const u8,

    pub const json_field_names = .{
        .admin = "admin",
        .editor = "editor",
    };
};
