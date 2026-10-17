/// A summary of a flow version's metadata.
pub const ContactFlowVersionSummary = struct {
    /// The Amazon Resource Name (ARN) of the flow version.
    arn: ?[]const u8 = null,

    /// The Amazon Web Services Region where this resource was last modified.
    last_modified_region: ?[]const u8 = null,

    /// The timestamp when this resource was last modified.
    last_modified_time: ?i64 = null,

    /// The identifier of the flow version.
    version: ?i64 = null,

    /// The description of the flow version.
    version_description: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .version = "Version",
        .version_description = "VersionDescription",
    };
};
