const SearchQuantumTasksFilterOperator = @import("search_quantum_tasks_filter_operator.zig").SearchQuantumTasksFilterOperator;

/// A filter used to search for quantum tasks.
pub const SearchQuantumTasksFilter = struct {
    /// The name of the quantum task parameter to filter based on. Filter name can
    /// be either `quantumTaskArn`, `deviceArn`, `jobArn`, `status` or `createdAt`.
    name: []const u8,

    /// An operator to use for the filter.
    operator: SearchQuantumTasksFilterOperator,

    /// The values used to filter quantum tasks based on the filter name and
    /// operator.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .operator = "operator",
        .values = "values",
    };
};
