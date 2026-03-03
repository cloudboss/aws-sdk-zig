const IdleFinding = @import("idle_finding.zig").IdleFinding;

/// Describes the findings summary of the idle resources.
pub const IdleSummary = struct {
    /// The name of the finding group for the idle resources.
    name: ?IdleFinding = null,

    /// The count of idle resources in the finding group.
    value: f64 = 0,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
