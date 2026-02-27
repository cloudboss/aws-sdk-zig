/// Container for the parameters required to enable cold storage for an
/// OpenSearch Service
/// domain. For more information, see [Cold storage for
/// Amazon OpenSearch
/// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/cold-storage.html).
pub const ColdStorageOptions = struct {
    /// Whether to enable or disable cold storage on the domain. You must enable
    /// UltraWarm
    /// storage to enable cold storage.
    enabled: bool,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
