/// A structure that describes the values to use for the IAM Identity Center
/// settings when you update a web app.
pub const UpdateWebAppIdentityCenterConfig = struct {
    /// The IAM role used to access IAM Identity Center.
    role: ?[]const u8 = null,

    pub const json_field_names = .{
        .role = "Role",
    };
};
