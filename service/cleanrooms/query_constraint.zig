const QueryConstraintRequireOverlap = @import("query_constraint_require_overlap.zig").QueryConstraintRequireOverlap;

/// Provides any necessary query constraint information.
pub const QueryConstraint = union(enum) {
    /// An array of column names that specifies which columns are required in the
    /// JOIN statement.
    require_overlap: ?QueryConstraintRequireOverlap,

    pub const json_field_names = .{
        .require_overlap = "requireOverlap",
    };
};
