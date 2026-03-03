const ViewContent = @import("view_content.zig").ViewContent;

/// A view resource object. Contains metadata and content necessary to render
/// the
/// view.
pub const View = struct {
    /// The Amazon Resource Name (ARN) of the view.
    arn: ?[]const u8 = null,

    /// View content containing all content necessary to render a view except for
    /// runtime
    /// input data.
    content: ?ViewContent = null,

    /// The identifier of the view.
    id: ?[]const u8 = null,

    /// The name of the view.
    name: ?[]const u8 = null,

    /// The current version of the view.
    version: ?i32 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .content = "Content",
        .id = "Id",
        .name = "Name",
        .version = "Version",
    };
};
