const ComplianceQueryOperatorType = @import("compliance_query_operator_type.zig").ComplianceQueryOperatorType;

/// One or more filters. Use a filter to return a more specific list of results.
pub const ComplianceStringFilter = struct {
    /// The name of the filter.
    key: ?[]const u8 = null,

    /// The type of comparison that should be performed for the value: Equal,
    /// NotEqual, BeginWith,
    /// LessThan, or GreaterThan.
    @"type": ?ComplianceQueryOperatorType = null,

    /// The value for which to search.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .@"type" = "Type",
        .values = "Values",
    };
};
