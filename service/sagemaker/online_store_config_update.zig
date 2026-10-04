const StorageType = @import("storage_type.zig").StorageType;
const TtlDuration = @import("ttl_duration.zig").TtlDuration;

/// Updates the feature group online store configuration.
pub const OnlineStoreConfigUpdate = struct {
    /// The online store storage type to migrate the feature group to. Use this
    /// parameter to migrate an existing feature group from `Standard` to
    /// `Standard_V2` storage format, enabling support for the
    /// [UpdateRecord](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_feature_store_UpdateRecord.html) operation. Migration is a one-way operation and cannot be reversed.
    storage_type: ?StorageType = null,

    /// Time to live duration, where the record is hard deleted after the expiration
    /// time is reached; `ExpiresAt` = `EventTime` + `TtlDuration`. For information
    /// on HardDelete, see the
    /// [DeleteRecord](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_feature_store_DeleteRecord.html) API in the Amazon SageMaker API Reference guide.
    ttl_duration: ?TtlDuration = null,

    pub const json_field_names = .{
        .storage_type = "StorageType",
        .ttl_duration = "TtlDuration",
    };
};
