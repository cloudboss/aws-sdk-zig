const aws = @import("aws");

const Condition = @import("condition.zig").Condition;

/// Contains information about the criteria used for querying findings.
pub const FindingCriteria = struct {
    /// Represents a map of finding properties that match specified conditions and
    /// values when
    /// querying findings.
    criterion: ?[]const aws.map.MapEntry(Condition) = null,

    pub const json_field_names = .{
        .criterion = "Criterion",
    };
};
