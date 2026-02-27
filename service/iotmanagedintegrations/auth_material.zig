const SecretsManager = @import("secrets_manager.zig").SecretsManager;

/// The authorization material containing the Secrets Manager arn and version.
pub const AuthMaterial = struct {
    /// The name of the authorization material.
    auth_material_name: []const u8,

    secrets_manager: SecretsManager,

    pub const json_field_names = .{
        .auth_material_name = "AuthMaterialName",
        .secrets_manager = "SecretsManager",
    };
};
