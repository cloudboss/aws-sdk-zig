/// Options that specify the configuration of a persistent buffer.
/// To configure how OpenSearch Ingestion encrypts this data, set the
/// `EncryptionAtRestOptions`. For more information, see [Persistent
/// buffering](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/osis-features-overview.html#persistent-buffering).
pub const BufferOptions = struct {
    /// Whether persistent buffering should be enabled.
    persistent_buffer_enabled: bool,

    pub const json_field_names = .{
        .persistent_buffer_enabled = "PersistentBufferEnabled",
    };
};
