const TriggerSourceType = @import("trigger_source_type.zig").TriggerSourceType;

/// The source that triggered a notebook run in Amazon DataZone.
pub const TriggerSource = struct {
    /// The name of the trigger source.
    name: ?[]const u8 = null,

    /// The type of the trigger source. Valid values are `MANUAL`, `SCHEDULED`, and
    /// `WORKFLOW`.
    @"type": ?TriggerSourceType = null,

    pub const json_field_names = .{
        .name = "name",
        .@"type" = "type",
    };
};
