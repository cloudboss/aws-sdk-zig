/// A summary of a flow version's metadata.
pub const ContactFlowVersionSummary = struct {
    /// The Amazon Resource Name (ARN) of the view version.
    arn: ?[]const u8 = null,

    /// The identifier of the flow version.
    version: ?i64 = null,

    /// The description of the flow version.
    version_description: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .version = "Version",
        .version_description = "VersionDescription",
    };
};
