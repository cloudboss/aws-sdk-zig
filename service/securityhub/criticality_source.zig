const CriticalitySourceType = @import("criticality_source_type.zig").CriticalitySourceType;

/// Details the source and reason of a criticality.
pub const CriticalitySource = struct {
    /// The reason the criticality was assigned.
    reason: []const u8,

    /// The source of the criticality.
    source: CriticalitySourceType,

    pub const json_field_names = .{
        .reason = "Reason",
        .source = "Source",
    };
};
