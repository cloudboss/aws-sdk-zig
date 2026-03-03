/// Information about the hierarchy group.
pub const HierarchyGroupSummaryReference = struct {
    /// The Amazon Resource Name (ARN) for the hierarchy group.
    arn: ?[]const u8 = null,

    /// The unique identifier for the hierarchy group.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
    };
};
