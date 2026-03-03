/// Contains information about a version.
pub const ContactFlowModuleVersionSummary = struct {
    /// The Amazon Resource Name (ARN) of the flow module version.
    arn: ?[]const u8 = null,

    /// The version of the flow module.
    version: ?i64 = null,

    /// The description of the flow module version.
    version_description: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .version = "Version",
        .version_description = "VersionDescription",
    };
};
