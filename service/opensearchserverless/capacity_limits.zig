/// The maximum capacity limits for all OpenSearch Serverless collections, in
/// OpenSearch Compute Units (OCUs). These limits are used to scale your
/// collections based on the current workload. For more information, see
/// [Managing capacity limits for Amazon OpenSearch
/// Serverless](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-scaling.html).
pub const CapacityLimits = struct {
    /// The maximum indexing capacity for collections.
    max_indexing_capacity_in_ocu: ?i32 = null,

    /// The maximum search capacity for collections.
    max_search_capacity_in_ocu: ?i32 = null,

    pub const json_field_names = .{
        .max_indexing_capacity_in_ocu = "maxIndexingCapacityInOCU",
        .max_search_capacity_in_ocu = "maxSearchCapacityInOCU",
    };
};
