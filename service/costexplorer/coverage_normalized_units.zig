/// The amount of instance usage, in normalized units. You can use normalized
/// units to see
/// your EC2 usage for multiple sizes of instances in a uniform way. For
/// example, suppose
/// that you run an xlarge instance and a 2xlarge instance. If you run both
/// instances for
/// the same amount of time, the 2xlarge instance uses twice as much of your
/// reservation as
/// the xlarge instance, even though both instances show only one instance-hour.
/// When you
/// use normalized units instead of instance-hours, the xlarge instance used 8
/// normalized
/// units, and the 2xlarge instance used 16 normalized units.
///
/// For more information, see [Modifying Reserved
/// Instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ri-modifying.html)
/// in the *Amazon Elastic Compute Cloud User Guide for Linux
/// Instances*.
pub const CoverageNormalizedUnits = struct {
    /// The percentage of your used instance normalized units that a reservation
    /// covers.
    coverage_normalized_units_percentage: ?[]const u8,

    /// The number of normalized units that are covered by On-Demand Instances
    /// instead of a
    /// reservation.
    on_demand_normalized_units: ?[]const u8,

    /// The number of normalized units that a reservation covers.
    reserved_normalized_units: ?[]const u8,

    /// The total number of normalized units that you used.
    total_running_normalized_units: ?[]const u8,

    pub const json_field_names = .{
        .coverage_normalized_units_percentage = "CoverageNormalizedUnitsPercentage",
        .on_demand_normalized_units = "OnDemandNormalizedUnits",
        .reserved_normalized_units = "ReservedNormalizedUnits",
        .total_running_normalized_units = "TotalRunningNormalizedUnits",
    };
};
