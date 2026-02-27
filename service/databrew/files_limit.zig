const Order = @import("order.zig").Order;
const OrderedBy = @import("ordered_by.zig").OrderedBy;

/// Represents a limit imposed on number of Amazon S3 files that should be
/// selected for a
/// dataset from a connected Amazon S3 path.
pub const FilesLimit = struct {
    /// The number of Amazon S3 files to select.
    max_files: i32,

    /// A criteria to use for Amazon S3 files sorting before their selection. By
    /// default uses DESCENDING order, i.e. most recent files are selected first.
    /// Another
    /// possible value is ASCENDING.
    order: ?Order,

    /// A criteria to use for Amazon S3 files sorting before their selection. By
    /// default uses LAST_MODIFIED_DATE as
    /// a sorting criteria. Currently it's the only allowed value.
    ordered_by: ?OrderedBy,

    pub const json_field_names = .{
        .max_files = "MaxFiles",
        .order = "Order",
        .ordered_by = "OrderedBy",
    };
};
