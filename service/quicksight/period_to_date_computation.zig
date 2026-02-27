const TimeGranularity = @import("time_granularity.zig").TimeGranularity;
const DimensionField = @import("dimension_field.zig").DimensionField;
const MeasureField = @import("measure_field.zig").MeasureField;

/// The period to date computation configuration.
pub const PeriodToDateComputation = struct {
    /// The ID for a computation.
    computation_id: []const u8,

    /// The name of a computation.
    name: ?[]const u8,

    /// The time granularity setup of period to date computation. Choose from the
    /// following options:
    ///
    /// * YEAR: Year to date.
    ///
    /// * MONTH: Month to date.
    period_time_granularity: ?TimeGranularity,

    /// The time field that is used in a computation.
    time: ?DimensionField,

    /// The value field that is used in a computation.
    value: ?MeasureField,

    pub const json_field_names = .{
        .computation_id = "ComputationId",
        .name = "Name",
        .period_time_granularity = "PeriodTimeGranularity",
        .time = "Time",
        .value = "Value",
    };
};
