/// How long a running instance either used a reservation or was On-Demand.
pub const CoverageHours = struct {
    /// The percentage of instance hours that a reservation covered.
    coverage_hours_percentage: ?[]const u8,

    /// The number of instance running hours that On-Demand Instances covered.
    on_demand_hours: ?[]const u8,

    /// The number of instance running hours that reservations covered.
    reserved_hours: ?[]const u8,

    /// The total instance usage, in hours.
    total_running_hours: ?[]const u8,

    pub const json_field_names = .{
        .coverage_hours_percentage = "CoverageHoursPercentage",
        .on_demand_hours = "OnDemandHours",
        .reserved_hours = "ReservedHours",
        .total_running_hours = "TotalRunningHours",
    };
};
