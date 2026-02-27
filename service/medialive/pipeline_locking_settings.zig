const PipelineLockingMethod = @import("pipeline_locking_method.zig").PipelineLockingMethod;

/// Pipeline Locking Settings
pub const PipelineLockingSettings = struct {
    /// Optional. Only applies to CMAF Ingest Output Group and MediaPackage V2
    /// Output Group Only. Enter a value here to use a custom epoch, instead of the
    /// standard epoch (which started at 1970-01-01T00:00:00 UTC). Specify the start
    /// time of the custom epoch, in YYYY-MM-DDTHH:MM:SS in UTC. The time must be
    /// 2000-01-01T00:00:00 or later. Always set the MM:SS portion to 00:00.
    custom_epoch: ?[]const u8,

    /// The method to use to lock the video frames in the pipelines. sourceTimecode
    /// (default): Use the timecode in the source. videoAlignment: Lock frames that
    /// the encoder identifies as having matching content. If videoAlignment is
    /// selected, existing timecodes will not be used for any locking decisions.
    pipeline_locking_method: ?PipelineLockingMethod,

    pub const json_field_names = .{
        .custom_epoch = "CustomEpoch",
        .pipeline_locking_method = "PipelineLockingMethod",
    };
};
