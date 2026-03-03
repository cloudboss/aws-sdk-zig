/// A cross-account permission for a signing profile.
pub const Permission = struct {
    /// An AWS Signer action permitted as part of cross-account permissions.
    action: ?[]const u8 = null,

    /// The AWS principal that has been granted a cross-account permission.
    principal: ?[]const u8 = null,

    /// The signing profile version that a permission applies to.
    profile_version: ?[]const u8 = null,

    /// A unique identifier for a cross-account permission statement.
    statement_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .action = "action",
        .principal = "principal",
        .profile_version = "profileVersion",
        .statement_id = "statementId",
    };
};
