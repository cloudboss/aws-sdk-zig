const EBSItemFilter = @import("ebs_item_filter.zig").EBSItemFilter;
const S3ItemFilter = @import("s3_item_filter.zig").S3ItemFilter;

/// Item Filters represent all input item properties specified when the search
/// was created.
///
/// Contains either EBSItemFilters or S3ItemFilters
pub const ItemFilters = struct {
    /// This array can contain CreationTimes, FilePaths, LastModificationTimes, or
    /// Sizes objects.
    ebs_item_filters: ?[]const EBSItemFilter,

    /// This array can contain CreationTimes, ETags, ObjectKeys, Sizes, or
    /// VersionIds objects.
    s3_item_filters: ?[]const S3ItemFilter,

    pub const json_field_names = .{
        .ebs_item_filters = "EBSItemFilters",
        .s3_item_filters = "S3ItemFilters",
    };
};
