const ListTargetsFilterName = @import("list_targets_filter_name.zig").ListTargetsFilterName;

/// Information about a filter to apply to the list of returned targets. You can
/// filter by
/// target type, address, or status. For example, to filter results to
/// notification rules
/// that have active Amazon Q Developer in chat applications topics as targets,
/// you could specify a ListTargetsFilter
/// Name as `TargetType` and a Value of `SNS`, and a Name of `TARGET_STATUS` and
/// a Value of
/// `ACTIVE`.
pub const ListTargetsFilter = struct {
    /// The name of the attribute you want to use to filter the returned targets.
    name: ListTargetsFilterName,

    /// The value of the attribute you want to use to filter the returned targets.
    /// For example,
    /// if you specify `SNS` for the Target type, you could specify an Amazon
    /// Resource Name (ARN) for a topic as the value.
    value: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
