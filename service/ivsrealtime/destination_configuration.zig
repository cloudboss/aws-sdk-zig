const ChannelDestinationConfiguration = @import("channel_destination_configuration.zig").ChannelDestinationConfiguration;
const S3DestinationConfiguration = @import("s3_destination_configuration.zig").S3DestinationConfiguration;

/// Complex data type that defines destination-configuration objects.
pub const DestinationConfiguration = struct {
    /// An IVS channel to be used for broadcasting, for server-side composition.
    /// Either a
    /// `channel` or an `s3` must be specified.
    channel: ?ChannelDestinationConfiguration = null,

    /// Name that can be specified to help identify the destination.
    name: ?[]const u8 = null,

    /// An S3 storage configuration to be used for recording video data. Either a
    /// `channel` or an `s3` must be specified.
    s_3: ?S3DestinationConfiguration = null,

    pub const json_field_names = .{
        .channel = "channel",
        .name = "name",
        .s_3 = "s3",
    };
};
