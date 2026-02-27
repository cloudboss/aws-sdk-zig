const aws = @import("aws");

const ChannelResponse = @import("channel_response.zig").ChannelResponse;

/// Provides information about the general settings and status of all channels
/// for an application, including channels that aren't enabled for the
/// application.
pub const ChannelsResponse = struct {
    /// A map that contains a multipart response for each channel. For each item in
    /// this object, the ChannelType is the key and the Channel is the value.
    channels: []const aws.map.MapEntry(ChannelResponse),

    pub const json_field_names = .{
        .channels = "Channels",
    };
};
