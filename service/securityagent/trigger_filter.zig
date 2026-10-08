const TriggerFilterMatchMode = @import("trigger_filter_match_mode.zig").TriggerFilterMatchMode;
const TriggerFilterType = @import("trigger_filter_type.zig").TriggerFilterType;

/// A condition on a pull request value.
pub const TriggerFilter = struct {
    /// Whether the value must match the patterns. The default is `INCLUDE`.
    match_mode: ?TriggerFilterMatchMode = null,

    /// The regular expressions to match against the value.
    patterns: []const []const u8,

    /// The pull request value to match.
    type: TriggerFilterType,

    pub const json_field_names = .{
        .match_mode = "matchMode",
        .patterns = "patterns",
        .type = "type",
    };
};
