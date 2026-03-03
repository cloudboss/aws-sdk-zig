const BranchFilter = @import("branch_filter.zig").BranchFilter;
const EventMetadataFilterExpression = @import("event_metadata_filter_expression.zig").EventMetadataFilterExpression;

/// Contains filter criteria for listing events.
pub const FilterInput = struct {
    /// The branch filter criteria to apply when listing events.
    branch: ?BranchFilter = null,

    /// Event metadata filter criteria to apply when retrieving events.
    event_metadata: ?[]const EventMetadataFilterExpression = null,

    pub const json_field_names = .{
        .branch = "branch",
        .event_metadata = "eventMetadata",
    };
};
