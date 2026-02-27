/// View content containing all content necessary to render a view except for
/// runtime
/// input data.
pub const ViewContent = struct {
    /// A list of actions possible from the view
    actions: ?[]const []const u8,

    /// The schema representing the input data that the view template must be
    /// supplied to
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
