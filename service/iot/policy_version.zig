/// Describes a policy version.
pub const PolicyVersion = struct {
    /// The date and time the policy was created.
    create_date: ?i64,

    /// Specifies whether the policy version is the default.
    is_default_version: bool = false,

    /// The policy version ID.
    version_id: ?[]const u8,

    pub const json_field_names = .{
        .create_date = "createDate",
        .is_default_version = "isDefaultVersion",
        .version_id = "versionId",
    };
};
