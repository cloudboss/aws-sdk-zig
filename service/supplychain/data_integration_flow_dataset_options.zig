const DataIntegrationFlowDedupeStrategy = @import("data_integration_flow_dedupe_strategy.zig").DataIntegrationFlowDedupeStrategy;
const DataIntegrationFlowLoadType = @import("data_integration_flow_load_type.zig").DataIntegrationFlowLoadType;

/// The dataset options used in dataset source and target configurations.
pub const DataIntegrationFlowDatasetOptions = struct {
    /// The option to perform deduplication on data records sharing same primary key
    /// values. If disabled, transformed data with duplicate primary key values will
    /// ingest into dataset, for datasets within **asc** namespace, such duplicates
    /// will cause ingestion fail. If enabled without dedupeStrategy, deduplication
    /// is done by retaining a random data record among those sharing the same
    /// primary key values. If enabled with dedupeStragtegy, the deduplication is
    /// done following the strategy.
    ///
    /// Note that target dataset may have partition configured, when dedupe is
    /// enabled, it only dedupe against primary keys and retain only one record out
    /// of those duplicates regardless of its partition status.
    dedupe_records: ?bool,

    /// The deduplication strategy to dedupe the data records sharing same primary
    /// key values of the target dataset. This strategy only applies to target
    /// dataset with primary keys and with dedupeRecords option enabled. If
    /// transformed data still got duplicates after the dedupeStrategy evaluation, a
    /// random data record is chosen to be retained.
    dedupe_strategy: ?DataIntegrationFlowDedupeStrategy,

    /// The target dataset's data load type. This only affects how source S3 files
    /// are selected in the S3-to-dataset flow.
    ///
    /// * **REPLACE** - Target dataset will get replaced with the new file added
    ///   under the source s3 prefix.
    ///
    /// * **INCREMENTAL** - Target dataset will get updated with the up-to-date
    ///   content under S3 prefix incorporating any file additions or removals
    ///   there.
    load_type: ?DataIntegrationFlowLoadType,

    pub const json_field_names = .{
        .dedupe_records = "dedupeRecords",
        .dedupe_strategy = "dedupeStrategy",
        .load_type = "loadType",
    };
};
