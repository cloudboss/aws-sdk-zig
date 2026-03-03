/// Contains summary information about a user.
pub const UserSummary = struct {
    /// The Amazon Resource Name (ARN) of the user account.
    arn: ?[]const u8 = null,

    /// The identifier of the user account.
    id: ?[]const u8 = null,

    /// The Amazon Web Services Region where this resource was last modified.
    last_modified_region: ?[]const u8 = null,

    /// The timestamp when this resource was last modified.
    last_modified_time: ?i64 = null,

    /// The Amazon Connect user name of the user account.
    username: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .username = "Username",
    };
};
