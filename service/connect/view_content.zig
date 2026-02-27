/// View content containing all content necessary to render a view except for
/// runtime input data.
pub const ViewContent = struct {
    /// A list of possible actions from the view.
    actions: ?[]const []const u8,

    /// The data schema matching data that the view template must be provided to
    /// render.
    input_schema: ?[]const u8,

    /// The view template representing the structure of the view.
    template: ?[]const u8,

    pub const json_field_names = .{
        .actions = "Actions",
        .input_schema = "InputSchema",
        .template = "Template",
    };
};
