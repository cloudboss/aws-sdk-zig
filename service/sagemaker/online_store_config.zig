const OnlineStoreSecurityConfig = @import("online_store_security_config.zig").OnlineStoreSecurityConfig;
const StorageType = @import("storage_type.zig").StorageType;
const TtlDuration = @import("ttl_duration.zig").TtlDuration;

/// Use this to specify the Amazon Web Services Key Management Service (KMS) Key
/// ID, or `KMSKeyId`, for at rest data encryption. You can turn `OnlineStore`
/// on or off by specifying the `EnableOnlineStore` flag at General Assembly.
///
/// The default value is `False`.
pub const OnlineStoreConfig = struct {
    /// Turn `OnlineStore` off by specifying `False` for the `EnableOnlineStore`
    /// flag. Turn `OnlineStore` on by specifying `True` for the `EnableOnlineStore`
    /// flag.
    ///
    /// The default value is `False`.
    enable_online_store: ?bool = null,

    /// Use to specify KMS Key ID (`KMSKeyId`) for at-rest encryption of your
    /// `OnlineStore`.
    security_config: ?OnlineStoreSecurityConfig = null,

    /// Option for different tiers of low latency storage for real-time data
    /// retrieval.
    ///
    /// * `Standard`: A managed low latency data store for feature groups.
    /// * `InMemory`: A managed data store for feature groups that supports very low
    ///   latency retrieval.
    storage_type: ?StorageType = null,

    /// Time to live duration, where the record is hard deleted after the expiration
    /// time is reached; `ExpiresAt` = `EventTime` + `TtlDuration`. For information
    /// on HardDelete, see the
    /// [DeleteRecord](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_feature_store_DeleteRecord.html) API in the Amazon SageMaker API Reference guide.
    ttl_duration: ?TtlDuration = null,

    pub const json_field_names = .{
        .enable_online_store = "EnableOnlineStore",
        .security_config = "SecurityConfig",
        .storage_type = "StorageType",
        .ttl_duration = "TtlDuration",
    };
};
