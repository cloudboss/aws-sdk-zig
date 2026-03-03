const aws = @import("aws");

const ViewContent = @import("view_content.zig").ViewContent;
const ViewStatus = @import("view_status.zig").ViewStatus;
const ViewType = @import("view_type.zig").ViewType;

/// A view resource object. Contains metadata and content necessary to render
/// the view.
pub const View = struct {
    /// The Amazon Resource Name (ARN) of the view.
    arn: ?[]const u8 = null,

    /// View content containing all content necessary to render a view except for
    /// runtime input data.
    content: ?ViewContent = null,

    /// The timestamp of when the view was created.
    created_time: ?i64 = null,

    /// The description of the view.
    description: ?[]const u8 = null,

    /// The identifier of the view.
    id: ?[]const u8 = null,

    /// Latest timestamp of the `UpdateViewContent` or `CreateViewVersion`
    /// operations.
    last_modified_time: ?i64 = null,

    /// The name of the view.
    name: ?[]const u8 = null,

    /// Indicates the view status as either `SAVED` or `PUBLISHED`. The `PUBLISHED`
    /// status will initiate validation on the content.
    status: ?ViewStatus = null,

    /// The tags associated with the view resource (not specific to view version).
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of the view - `CUSTOMER_MANAGED`.
    @"type": ?ViewType = null,

    /// Current version of the view.
    version: i32 = 0,

    /// The description of the version.
    version_description: ?[]const u8 = null,

    /// Indicates the checksum value of the latest published view content.
    view_content_sha_256: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .content = "Content",
        .created_time = "CreatedTime",
        .description = "Description",
        .id = "Id",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .status = "Status",
        .tags = "Tags",
        .@"type" = "Type",
        .version = "Version",
        .version_description = "VersionDescription",
        .view_content_sha_256 = "ViewContentSha256",
    };
};
