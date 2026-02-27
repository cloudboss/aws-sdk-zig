const ViewStatus = @import("view_status.zig").ViewStatus;
const ViewType = @import("view_type.zig").ViewType;

/// A summary of a view's metadata.
pub const ViewSummary = struct {
    /// The Amazon Resource Name (ARN) of the view.
    arn: ?[]const u8,

    /// The description of the view.
    description: ?[]const u8,

    /// The identifier of the view.
    id: ?[]const u8,

    /// The name of the view.
    name: ?[]const u8,

    /// Indicates the view status as either `SAVED` or `PUBLISHED`. The `PUBLISHED`
    /// status will initiate validation on the content.
    status: ?ViewStatus,

    /// The type of the view.
    type: ?ViewType,

    pub const json_field_names = .{
        .arn = "Arn",
        .description = "Description",
        .id = "Id",
        .name = "Name",
        .status = "Status",
        .type = "Type",
    };
};
