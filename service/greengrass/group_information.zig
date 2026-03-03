/// Information about a group.
pub const GroupInformation = struct {
    /// The ARN of the group.
    arn: ?[]const u8 = null,

    /// The time, in milliseconds since the epoch, when the group was created.
    creation_timestamp: ?[]const u8 = null,

    /// The ID of the group.
    id: ?[]const u8 = null,

    /// The time, in milliseconds since the epoch, when the group was last updated.
    last_updated_timestamp: ?[]const u8 = null,

    /// The ID of the latest version associated with the group.
    latest_version: ?[]const u8 = null,

    /// The ARN of the latest version associated with the group.
    latest_version_arn: ?[]const u8 = null,

    /// The name of the group.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_timestamp = "CreationTimestamp",
        .id = "Id",
        .last_updated_timestamp = "LastUpdatedTimestamp",
        .latest_version = "LatestVersion",
        .latest_version_arn = "LatestVersionArn",
        .name = "Name",
    };
};
