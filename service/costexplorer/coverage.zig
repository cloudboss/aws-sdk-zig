const CoverageCost = @import("coverage_cost.zig").CoverageCost;
const CoverageHours = @import("coverage_hours.zig").CoverageHours;
const CoverageNormalizedUnits = @import("coverage_normalized_units.zig").CoverageNormalizedUnits;

/// The amount of instance usage that a reservation covered.
pub const Coverage = struct {
    /// The amount of cost that the reservation covered.
    coverage_cost: ?CoverageCost = null,

    /// The amount of instance usage that the reservation covered, in hours.
    coverage_hours: ?CoverageHours = null,

    /// The amount of instance usage that the reservation covered, in normalized
    /// units.
    coverage_normalized_units: ?CoverageNormalizedUnits = null,

    pub const json_field_names = .{
        .coverage_cost = "CoverageCost",
        .coverage_hours = "CoverageHours",
        .coverage_normalized_units = "CoverageNormalizedUnits",
    };
};
