const Channel = @import("channel.zig").Channel;

/// The configuration for notifications stored for each profiling group. This
/// includes up to
/// to two channels and a list of event publishers associated with each channel.
pub const NotificationConfiguration = struct {
    /// List of up to two channels to be used for sending notifications for events
    /// detected from
    /// the application profile.
    channels: ?[]const Channel,

    pub const json_field_names = .{
        .channels = "channels",
    };
};
