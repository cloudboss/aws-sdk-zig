/// Contains information about a page configuration in a workspace, including
/// the view assigned to the page.
pub const WorkspacePage = struct {
    /// A JSON string containing input parameters passed to the view when the page
    /// is rendered.
    input_data: ?[]const u8 = null,

    /// The page identifier. System pages include `HOME` and `AGENT_EXPERIENCE`.
    page: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the view associated with this page.
    resource_arn: ?[]const u8 = null,

    /// The URL-friendly identifier for the page.
    slug: ?[]const u8 = null,

    pub const json_field_names = .{
        .input_data = "InputData",
        .page = "Page",
        .resource_arn = "ResourceArn",
        .slug = "Slug",
    };
};
