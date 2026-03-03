const LastRefreshType = @import("last_refresh_type.zig").LastRefreshType;
const ViewRepresentation = @import("view_representation.zig").ViewRepresentation;

/// A structure containing details for representations.
pub const ViewDefinition = struct {
    /// The definer of a view in SQL.
    definer: ?[]const u8 = null,

    /// You can set this flag as true to instruct the engine not to push
    /// user-provided operations into the logical plan of the view during query
    /// planning. However, setting this flag does not guarantee that the engine will
    /// comply. Refer to the engine's documentation to understand the guarantees
    /// provided, if any.
    is_protected: ?bool = null,

    /// Sets the method used for the most recent refresh.
    last_refresh_type: ?LastRefreshType = null,

    /// Auto refresh interval in seconds for the materialized view. If not
    /// specified, the view will
    /// not automatically refresh.
    refresh_seconds: ?i64 = null,

    /// A list of representations.
    representations: ?[]const ViewRepresentation = null,

    /// A list of table Amazon Resource Names (ARNs).
    sub_objects: ?[]const []const u8 = null,

    /// List of the Apache Iceberg table versions referenced by the materialized
    /// view.
    sub_object_version_ids: ?[]const i64 = null,

    /// The ID value that identifies this view's version. For materialized views,
    /// the version ID is the Apache Iceberg table's snapshot ID.
    view_version_id: i64 = 0,

    /// The version ID of the Apache Iceberg table.
    view_version_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .definer = "Definer",
        .is_protected = "IsProtected",
        .last_refresh_type = "LastRefreshType",
        .refresh_seconds = "RefreshSeconds",
        .representations = "Representations",
        .sub_objects = "SubObjects",
        .sub_object_version_ids = "SubObjectVersionIds",
        .view_version_id = "ViewVersionId",
        .view_version_token = "ViewVersionToken",
    };
};
