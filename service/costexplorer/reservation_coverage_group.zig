const aws = @import("aws");

const Coverage = @import("coverage.zig").Coverage;

/// A group of reservations that share a set of attributes.
pub const ReservationCoverageGroup = struct {
    /// The attributes for this group of reservations.
    attributes: ?[]const aws.map.StringMapEntry = null,

    /// How much instance usage this group of reservations covered.
    coverage: ?Coverage = null,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .coverage = "Coverage",
    };
};
