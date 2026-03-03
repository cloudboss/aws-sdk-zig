const Status = @import("status.zig").Status;
const ChannelType = @import("channel_type.zig").ChannelType;
const SingleMasterConfiguration = @import("single_master_configuration.zig").SingleMasterConfiguration;

/// A structure that encapsulates a signaling channel's metadata and properties.
pub const ChannelInfo = struct {
    /// The Amazon Resource Name (ARN) of the signaling channel.
    channel_arn: ?[]const u8 = null,

    /// The name of the signaling channel.
    channel_name: ?[]const u8 = null,

    /// Current status of the signaling channel.
    channel_status: ?Status = null,

    /// The type of the signaling channel.
    channel_type: ?ChannelType = null,

    /// The time at which the signaling channel was created.
    creation_time: ?i64 = null,

    /// A structure that contains the configuration for the `SINGLE_MASTER` channel
    /// type.
    single_master_configuration: ?SingleMasterConfiguration = null,

    /// The current version of the signaling channel.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_arn = "ChannelARN",
        .channel_name = "ChannelName",
        .channel_status = "ChannelStatus",
        .channel_type = "ChannelType",
        .creation_time = "CreationTime",
        .single_master_configuration = "SingleMasterConfiguration",
        .version = "Version",
    };
};
