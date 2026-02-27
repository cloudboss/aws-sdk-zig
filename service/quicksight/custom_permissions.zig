const Capabilities = @import("capabilities.zig").Capabilities;

/// The custom permissions profile.
pub const CustomPermissions = struct {
    /// The Amazon Resource Name (ARN) of the custom permissions profile.
    arn: ?[]const u8,

    /// A set of actions in the custom permissions profile.
    capabilities: ?Capabilities,

    /// The name of the custom permissions profile.
    custom_permissions_name: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .capabilities = "Capabilities",
        .custom_permissions_name = "CustomPermissionsName",
    };
};
