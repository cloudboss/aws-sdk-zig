/// The General Authorization reference by authorization material name.
pub const GeneralAuthorizationName = struct {
    /// The name of the authorization material.
    auth_material_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .auth_material_name = "AuthMaterialName",
    };
};
