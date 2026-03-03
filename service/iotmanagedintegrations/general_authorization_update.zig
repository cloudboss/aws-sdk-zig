const AuthMaterial = @import("auth_material.zig").AuthMaterial;

/// The General Authorization update information containing authorization
/// materials to add or update.
pub const GeneralAuthorizationUpdate = struct {
    /// The authorization materials to add.
    auth_materials_to_add: ?[]const AuthMaterial = null,

    /// The authorization materials to update.
    auth_materials_to_update: ?[]const AuthMaterial = null,

    pub const json_field_names = .{
        .auth_materials_to_add = "AuthMaterialsToAdd",
        .auth_materials_to_update = "AuthMaterialsToUpdate",
    };
};
