const CalculationStatus = @import("calculation_status.zig").CalculationStatus;

/// Summary information for a notebook calculation.
pub const CalculationSummary = struct {
    /// The calculation execution UUID.
    calculation_execution_id: ?[]const u8,

    /// A description of the calculation.
    description: ?[]const u8,

    /// Contains information about the status of the calculation.
    status: ?CalculationStatus,

    pub const json_field_names = .{
        .calculation_execution_id = "CalculationExecutionId",
        .description = "Description",
        .status = "Status",
    };
};
