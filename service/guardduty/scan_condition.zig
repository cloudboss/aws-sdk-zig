const ScanConditionPair = @import("scan_condition_pair.zig").ScanConditionPair;

/// Contains information about the condition.
pub const ScanCondition = struct {
    /// Represents an *mapEqual* condition to be applied to a single field when
    /// triggering for malware scan.
    map_equals: []const ScanConditionPair,

    pub const json_field_names = .{
        .map_equals = "MapEquals",
    };
};
