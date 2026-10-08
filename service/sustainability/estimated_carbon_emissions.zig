const aws = @import("aws");

const Emissions = @import("emissions.zig").Emissions;
const TimePeriod = @import("time_period.zig").TimePeriod;

/// Contains estimated carbon emissions data for a specific time period and
/// dimension grouping.
pub const EstimatedCarbonEmissions = struct {
    /// The dimensions used to group emissions values.
    dimensions_values: []const aws.map.StringMapEntry,

    /// The emissions values for the requested emissions types.
    emissions_values: []const aws.map.MapEntry(Emissions),

    /// The semantic version-formatted string that indicates the methodology version
    /// used to calculate the emission values.
    ///
    /// The AWS Sustainability service reflects the most recent model version for
    /// every month. You will not see two entries for the same month with different
    /// `ModelVersion` values. To track the evolution of the methodology and compare
    /// emission values from previous versions, we recommend creating a [Data
    /// Export](https://docs.aws.amazon.com/cur/latest/userguide/what-is-data-exports.html).
    model_version: []const u8,

    /// The reporting period for emission values.
    time_period: TimePeriod,

    pub const json_field_names = .{
        .dimensions_values = "DimensionsValues",
        .emissions_values = "EmissionsValues",
        .model_version = "ModelVersion",
        .time_period = "TimePeriod",
    };
};
