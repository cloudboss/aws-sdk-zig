const EnrollmentFilterName = @import("enrollment_filter_name.zig").EnrollmentFilterName;

/// Describes a filter that returns a more specific list of account enrollment
/// statuses.
/// Use this filter with the GetEnrollmentStatusesForOrganization
/// action.
pub const EnrollmentFilter = struct {
    /// The name of the filter.
    ///
    /// Specify `Status` to return accounts with a specific enrollment status (for
    /// example, `Active`).
    name: ?EnrollmentFilterName = null,

    /// The value of the filter.
    ///
    /// The valid values are `Active`, `Inactive`, `Pending`,
    /// and `Failed`.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .values = "values",
    };
};
