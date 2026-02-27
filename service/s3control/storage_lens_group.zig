const StorageLensGroupFilter = @import("storage_lens_group_filter.zig").StorageLensGroupFilter;

/// A custom grouping of objects that include filters for prefixes, suffixes,
/// object tags,
/// object size, or object age. You can create an S3 Storage Lens group that
/// includes a single
/// filter or multiple filter conditions. To specify multiple filter conditions,
/// you use
/// `AND` or `OR` logical operators.
pub const StorageLensGroup = struct {
    /// Sets the criteria for the Storage Lens group data that is displayed. For
    /// multiple filter
    /// conditions, the `AND` or `OR` logical operator is used.
    filter: StorageLensGroupFilter,

    /// Contains the name of the Storage Lens group.
    name: []const u8,

    /// Contains the Amazon Resource Name (ARN) of the Storage Lens group. This
    /// property is
    /// read-only.
    storage_lens_group_arn: ?[]const u8,
};
