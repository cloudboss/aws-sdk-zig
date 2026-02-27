const StatusValues = @import("status_values.zig").StatusValues;

/// Filters the operation status list based on the passed attribute value.
pub const OperationStatusFilter = struct {
    /// Filters the list operations result based on the status attribute.
    status: ?StatusValues,

    pub const json_field_names = .{
        .status = "Status",
    };
};
