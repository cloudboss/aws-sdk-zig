const AnchorType = @import("anchor_type.zig").AnchorType;
const TimeGranularity = @import("time_granularity.zig").TimeGranularity;

/// The definition of the Anchor.
pub const Anchor = struct {
    /// The `AnchorType` for the Anchor.
    anchor_type: ?AnchorType = null,

    /// The offset of the Anchor.
    offset: i32 = 0,

    /// The `TimeGranularity` of the Anchor.
    time_granularity: ?TimeGranularity = null,

    pub const json_field_names = .{
        .anchor_type = "AnchorType",
        .offset = "Offset",
        .time_granularity = "TimeGranularity",
    };
};
