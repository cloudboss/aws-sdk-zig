/// Represents a condition that when matched will be added to the response of
/// the
/// operation.
pub const CoverageFilterCondition = struct {
    /// Represents an equal condition that is applied to a single field while
    /// retrieving the
    /// coverage details.
    equals: ?[]const []const u8 = null,

    /// Represents a not equal condition that is applied to a single field while
    /// retrieving the
    /// coverage details.
    not_equals: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .equals = "Equals",
        .not_equals = "NotEquals",
    };
};
