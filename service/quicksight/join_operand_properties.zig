const OutputColumnNameOverride = @import("output_column_name_override.zig").OutputColumnNameOverride;

/// Properties that control how columns are handled for a join operand,
/// including column name overrides.
pub const JoinOperandProperties = struct {
    /// A list of column name overrides to apply to the join operand's output
    /// columns.
    output_column_name_overrides: []const OutputColumnNameOverride,

    pub const json_field_names = .{
        .output_column_name_overrides = "OutputColumnNameOverrides",
    };
};
