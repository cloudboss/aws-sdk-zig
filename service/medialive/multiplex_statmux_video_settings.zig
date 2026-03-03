/// Statmux rate control settings
pub const MultiplexStatmuxVideoSettings = struct {
    /// Maximum statmux bitrate.
    maximum_bitrate: ?i32 = null,

    /// Minimum statmux bitrate.
    minimum_bitrate: ?i32 = null,

    /// The purpose of the priority is to use a combination of the\nmultiplex rate
    /// control algorithm and the QVBR capability of the\nencoder to prioritize the
    /// video quality of some channels in a\nmultiplex over others. Channels that
    /// have a higher priority will\nget higher video quality at the expense of the
    /// video quality of\nother channels in the multiplex with lower priority.
    priority: ?i32 = null,

    pub const json_field_names = .{
        .maximum_bitrate = "MaximumBitrate",
        .minimum_bitrate = "MinimumBitrate",
        .priority = "Priority",
    };
};
