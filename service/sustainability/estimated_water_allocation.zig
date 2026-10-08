const aws = @import("aws");

const WaterAllocation = @import("water_allocation.zig").WaterAllocation;
const TimePeriod = @import("time_period.zig").TimePeriod;

/// Contains estimated water allocation data for a specific time period and
/// dimension grouping.
pub const EstimatedWaterAllocation = struct {
    /// The allocation values for the requested water allocation types.
    allocation_values: []const aws.map.MapEntry(WaterAllocation),

    /// The dimensions used to group water allocation values.
    dimensions_values: []const aws.map.StringMapEntry,

    /// The semantic version-formatted string that indicates the methodology version
    /// used to calculate the water allocation values.
    ///
    /// The AWS Sustainability service reflects the most recent model version for
    /// every month. You will not see two entries for the same month with different
    /// `ModelVersion` values.
    model_version: []const u8,

    /// The reporting period for water allocation values.
    time_period: TimePeriod,

    pub const json_field_names = .{
        .allocation_values = "AllocationValues",
        .dimensions_values = "DimensionsValues",
        .model_version = "ModelVersion",
        .time_period = "TimePeriod",
    };
};
