const aws = @import("aws");

/// Information about a definition.
pub const DefinitionInformation = struct {
    /// The ARN of the definition.
    arn: ?[]const u8 = null,

    /// The time, in milliseconds since the epoch, when the definition was created.
    creation_timestamp: ?[]const u8 = null,

    /// The ID of the definition.
    id: ?[]const u8 = null,

    /// The time, in milliseconds since the epoch, when the definition was last
    /// updated.
    last_updated_timestamp: ?[]const u8 = null,

    /// The ID of the latest version associated with the definition.
    latest_version: ?[]const u8 = null,

    /// The ARN of the latest version associated with the definition.
    latest_version_arn: ?[]const u8 = null,

    /// The name of the definition.
    name: ?[]const u8 = null,

    /// Tag(s) attached to the resource arn.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_timestamp = "CreationTimestamp",
        .id = "Id",
        .last_updated_timestamp = "LastUpdatedTimestamp",
        .latest_version = "LatestVersion",
        .latest_version_arn = "LatestVersionArn",
        .name = "Name",
        .tags = "Tags",
    };
};
