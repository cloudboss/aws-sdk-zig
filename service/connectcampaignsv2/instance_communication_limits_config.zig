const CommunicationLimits = @import("communication_limits.zig").CommunicationLimits;

/// Instance Communication limits config
pub const InstanceCommunicationLimitsConfig = struct {
    all_channel_subtypes: ?CommunicationLimits,

    pub const json_field_names = .{
        .all_channel_subtypes = "allChannelSubtypes",
    };
};
