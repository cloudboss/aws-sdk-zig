const TransformationToolName = @import("transformation_tool_name.zig").TransformationToolName;

/// Information of the transformation tool that can be used to migrate and
/// modernize the
/// application.
pub const TransformationTool = struct {
    /// Description of the tool.
    description: ?[]const u8 = null,

    /// Name of the tool.
    name: ?TransformationToolName = null,

    /// URL for installing the tool.
    tranformation_tool_installation_link: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .tranformation_tool_installation_link = "tranformationToolInstallationLink",
    };
};
