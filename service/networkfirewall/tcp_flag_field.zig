const TCPFlag = @import("tcp_flag.zig").TCPFlag;

/// TCP flags and masks to inspect packets for, used in stateless rules
/// MatchAttributes settings.
pub const TCPFlagField = struct {
    /// Used in conjunction with the `Masks` setting to define the flags that must
    /// be set and flags that must not be set in order for the packet to match. This
    /// setting can only specify values that are also specified in the `Masks`
    /// setting.
    ///
    /// For the flags that are specified in the masks setting, the following must be
    /// true for the packet to match:
    ///
    /// * The ones that are set in this flags setting must be set in the packet.
    ///
    /// * The ones that are not set in this flags setting must also not be set in
    ///   the packet.
    flags: []const TCPFlag,

    /// The set of flags to consider in the inspection. To inspect all flags in the
    /// valid values list, leave this with no setting.
    masks: ?[]const TCPFlag,

    pub const json_field_names = .{
        .flags = "Flags",
        .masks = "Masks",
    };
};
