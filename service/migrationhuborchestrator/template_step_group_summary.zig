/// The summary of the step group in the template.
pub const TemplateStepGroupSummary = struct {
    /// The ID of the step group.
    id: ?[]const u8,

    /// The name of the step group.
    name: ?[]const u8,

    /// The next step group.
    next: ?[]const []const u8,

    /// The previous step group.
    previous: ?[]const []const u8,

    pub const json_field_names = .{
        .id = "id",
        .name = "name",
        .next = "next",
        .previous = "previous",
    };
};
