/// Information about a version.
pub const VersionInformation = struct {
    /// The ARN of the version.
    arn: ?[]const u8,

    /// The time, in milliseconds since the epoch, when the version was created.
    creation_timestamp: ?[]const u8,

    /// The ID of the parent definition that the version is associated with.
    id: ?[]const u8,

    /// The ID of the version.
    version: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_timestamp = "CreationTimestamp",
        .id = "Id",
        .version = "Version",
    };
};
