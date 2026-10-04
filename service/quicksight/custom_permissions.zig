const Capabilities = @import("capabilities.zig").Capabilities;
const Governance = @import("governance.zig").Governance;

/// The custom permissions profile.
pub const CustomPermissions = struct {
    /// The Amazon Resource Name (ARN) of the custom permissions profile.
    arn: ?[]const u8 = null,

    /// A set of actions in the custom permissions profile.
    capabilities: ?Capabilities = null,

    /// The name of the custom permissions profile.
    custom_permissions_name: ?[]const u8 = null,

    /// The governance configuration for the custom permissions profile. When you
    /// enable governance for a category, Amazon Quick denies access to any current
    /// or new capability in that category unless you explicitly set that capability
    /// to `ALLOW` in `Capabilities`.
    governance: ?Governance = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .capabilities = "Capabilities",
        .custom_permissions_name = "CustomPermissionsName",
        .governance = "Governance",
    };
};
