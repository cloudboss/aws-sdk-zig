const TtlDuration = @import("ttl_duration.zig").TtlDuration;

/// Updates the feature group online store configuration.
pub const OnlineStoreConfigUpdate = struct {
    /// Time to live duration, where the record is hard deleted after the expiration
    /// time is reached; `ExpiresAt` = `EventTime` + `TtlDuration`. For information
    /// on HardDelete, see the
    /// [DeleteRecord](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_feature_store_DeleteRecord.html) API in the Amazon SageMaker API Reference guide.
    ttl_duration: ?TtlDuration,

    pub const json_field_names = .{
        .ttl_duration = "TtlDuration",
    };
};
