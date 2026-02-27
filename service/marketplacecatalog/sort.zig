const SortOrder = @import("sort_order.zig").SortOrder;

/// An object that contains two attributes, `SortBy` and
/// `SortOrder`.
pub const Sort = struct {
    /// For `ListEntities`, supported attributes include
    /// `LastModifiedDate` (default) and `EntityId`. In addition to
    /// `LastModifiedDate` and `EntityId`, each
    /// `EntityType` might support additional fields.
    ///
    /// For `ListChangeSets`, supported attributes include `StartTime`
    /// and `EndTime`.
    sort_by: ?[]const u8,

    /// The sorting order. Can be `ASCENDING` or `DESCENDING`. The
    /// default value is `DESCENDING`.
    sort_order: ?SortOrder,

    pub const json_field_names = .{
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};
