/// Determines the level of detail about either provisioned or on-demand
/// throughput
/// consumption that is returned in the response:
///
/// * `INDEXES` - The response includes the aggregate
/// `ConsumedCapacity` for the operation, together with
/// `ConsumedCapacity` for each table and secondary index that was
/// accessed.
///
/// Note that some operations, such as `GetItem` and
/// `BatchGetItem`, do not access any indexes at all. In these cases,
/// specifying `INDEXES` will only return `ConsumedCapacity`
/// information for table(s).
///
/// * `TOTAL` - The response includes only the aggregate
/// `ConsumedCapacity` for the operation.
///
/// * `NONE` - No `ConsumedCapacity` details are included in the
/// response.
pub const ReturnConsumedCapacity = enum {
    indexes,
    total,
    none,

    pub const json_field_names = .{
        .indexes = "INDEXES",
        .total = "TOTAL",
        .none = "NONE",
    };
};
