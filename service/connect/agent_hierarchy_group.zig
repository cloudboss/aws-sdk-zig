/// Information about an agent hierarchy group.
pub const AgentHierarchyGroup = struct {
    /// The Amazon Resource Name (ARN) of the group.
    arn: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
