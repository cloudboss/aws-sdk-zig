const DiversityColumn = @import("diversity_column.zig").DiversityColumn;

/// Configuration that controls diversity of recommendation results by capping
/// the representation of specified item columns.
pub const DiversityConfig = struct {
    /// A list of up to two diversity columns. Each column defines a cap on the
    /// number or percentage of recommended items that share the same value for that
    /// column.
    diversity_columns: ?[]const DiversityColumn = null,

    pub const json_field_names = .{
        .diversity_columns = "DiversityColumns",
    };
};
