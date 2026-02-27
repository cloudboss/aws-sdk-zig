const LocalSizeConfig = @import("local_size_config.zig").LocalSizeConfig;

/// The configuration details required to delete the connection of the stream
/// from the Edge Agent.
pub const DeletionConfig = struct {
    /// The `boolean` value used to indicate whether or not you want to mark the
    /// media for deletion, once it has been uploaded to
    /// the Kinesis Video Stream cloud. The media files can be deleted if any of the
    /// deletion configuration values are
    /// set to `true`, such as when the limit for the `EdgeRetentionInHours`, or the
    /// `MaxLocalMediaSizeInMB`, has been reached.
    ///
    /// Since the default value is set to `true`, configure the uploader schedule
    /// such
    /// that the media files are not being deleted before they are initially
    /// uploaded to the Amazon Web Services cloud.
    delete_after_upload: ?bool,

    /// The number of hours that you want to retain the data in the stream on the
    /// Edge Agent. The default value of the retention
    /// time is 720 hours, which translates to 30 days.
    edge_retention_in_hours: ?i32,

    /// The value of the local size required in order to delete the edge
    /// configuration.
    local_size_config: ?LocalSizeConfig,

    pub const json_field_names = .{
        .delete_after_upload = "DeleteAfterUpload",
        .edge_retention_in_hours = "EdgeRetentionInHours",
        .local_size_config = "LocalSizeConfig",
    };
};
