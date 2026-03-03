const DeletionConfig = @import("deletion_config.zig").DeletionConfig;
const RecorderConfig = @import("recorder_config.zig").RecorderConfig;
const UploaderConfig = @import("uploader_config.zig").UploaderConfig;

/// A description of the stream's edge configuration that will be used to sync
/// with the Edge Agent IoT Greengrass component. The Edge Agent component will
/// run
/// on an IoT Hub Device setup at your premise.
pub const EdgeConfig = struct {
    /// The deletion configuration is made up of the retention time
    /// (`EdgeRetentionInHours`) and local size configuration
    /// (`LocalSizeConfig`) details that are used to make the deletion.
    deletion_config: ?DeletionConfig = null,

    /// The "**Internet of Things (IoT) Thing**" Arn of the stream.
    hub_device_arn: []const u8,

    /// The recorder configuration consists of the local `MediaSourceConfig`
    /// details, that are used as
    /// credentials to access the local media files streamed on the camera.
    recorder_config: RecorderConfig,

    /// The uploader configuration contains the `ScheduleExpression` details that
    /// are used to
    /// schedule upload jobs for the recorded media files from the Edge Agent to a
    /// Kinesis Video Stream.
    uploader_config: ?UploaderConfig = null,

    pub const json_field_names = .{
        .deletion_config = "DeletionConfig",
        .hub_device_arn = "HubDeviceArn",
        .recorder_config = "RecorderConfig",
        .uploader_config = "UploaderConfig",
    };
};
