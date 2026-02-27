const X12SplitBy = @import("x12_split_by.zig").X12SplitBy;

/// Contains options for splitting X12 EDI files into smaller units. This is
/// useful for processing large EDI files more efficiently.
pub const X12SplitOptions = struct {
    /// Specifies the method used to split X12 EDI files. Valid values include
    /// `TRANSACTION` (split by individual transaction sets), or `NONE` (no
    /// splitting).
    split_by: X12SplitBy,

    pub const json_field_names = .{
        .split_by = "splitBy",
    };
};
