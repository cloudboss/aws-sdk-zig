const Smpte2110ReceiverGroup = @import("smpte_2110_receiver_group.zig").Smpte2110ReceiverGroup;

/// Configures the sources for the SMPTE 2110 Receiver Group input.
pub const Smpte2110ReceiverGroupSettings = struct {
    smpte_2110_receiver_groups: ?[]const Smpte2110ReceiverGroup,

    pub const json_field_names = .{
        .smpte_2110_receiver_groups = "Smpte2110ReceiverGroups",
    };
};
