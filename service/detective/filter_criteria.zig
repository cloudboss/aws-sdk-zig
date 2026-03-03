const DateFilter = @import("date_filter.zig").DateFilter;
const StringFilter = @import("string_filter.zig").StringFilter;

/// Details on the criteria used to define the filter for investigation results.
pub const FilterCriteria = struct {
    /// Filter the investigation results based on when the investigation was
    /// created.
    created_time: ?DateFilter = null,

    /// Filter the investigation results based on the Amazon Resource Name (ARN) of
    /// the entity.
    entity_arn: ?StringFilter = null,

    /// Filter the investigation results based on the severity.
    severity: ?StringFilter = null,

    /// Filter the investigation results based on the state.
    state: ?StringFilter = null,

    /// Filter the investigation results based on the status.
    status: ?StringFilter = null,

    pub const json_field_names = .{
        .created_time = "CreatedTime",
        .entity_arn = "EntityArn",
        .severity = "Severity",
        .state = "State",
        .status = "Status",
    };
};
