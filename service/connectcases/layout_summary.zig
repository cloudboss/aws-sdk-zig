/// Object for the summarized details of the layout.
pub const LayoutSummary = struct {
    /// The Amazon Resource Name (ARN) of the layout.
    layout_arn: []const u8,

    /// The unique identifier for of the layout.
    layout_id: []const u8,

    /// The name of the layout.
    name: []const u8,

    pub const json_field_names = .{
        .layout_arn = "layoutArn",
        .layout_id = "layoutId",
        .name = "name",
    };
};
