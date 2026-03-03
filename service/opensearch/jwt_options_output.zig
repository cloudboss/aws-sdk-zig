/// Describes the JWT options configured for the domain.
pub const JWTOptionsOutput = struct {
    /// True if JWT use is enabled.
    enabled: ?bool = null,

    /// The key used to verify the signature of incoming JWT requests.
    public_key: ?[]const u8 = null,

    /// The key used for matching the JWT roles attribute.
    roles_key: ?[]const u8 = null,

    /// The key used for matching the JWT subject attribute.
    subject_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .public_key = "PublicKey",
        .roles_key = "RolesKey",
        .subject_key = "SubjectKey",
    };
};
