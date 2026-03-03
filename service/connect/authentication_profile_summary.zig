/// This API is in preview release for Amazon Connect and is subject to change.
/// To
/// request access to this API, contact Amazon Web Services Support.
///
/// A summary of a given authentication profile.
pub const AuthenticationProfileSummary = struct {
    /// The Amazon Resource Name (ARN) of the authentication profile summary.
    arn: ?[]const u8 = null,

    /// The unique identifier of the authentication profile.
    id: ?[]const u8 = null,

    /// Shows whether the authentication profile is the default authentication
    /// profile for the Amazon Connect
    /// instance. The default authentication profile applies to all agents in an
    /// Amazon Connect instance, unless
    /// overridden by another authentication profile.
    is_default: bool = false,

    /// The Amazon Web Services Region when the authentication profile summary was
    /// last modified.
    last_modified_region: ?[]const u8 = null,

    /// The timestamp when the authentication profile summary was last modified.
    last_modified_time: ?i64 = null,

    /// The name of the authentication profile summary.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .is_default = "IsDefault",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
    };
};
