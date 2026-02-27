/// Sets the number of *concurrent processes* that transfer OData records
/// from your SAP instance. A concurrent process is query that retrieves a batch
/// of records as
/// part of a flow run. Amazon AppFlow can run multiple concurrent processes in
/// parallel to
/// transfer data faster.
pub const SAPODataParallelismConfig = struct {
    /// The maximum number of processes that Amazon AppFlow runs at the same time
    /// when it
    /// retrieves your data from your SAP application.
    max_parallelism: i32,

    pub const json_field_names = .{
        .max_parallelism = "maxParallelism",
    };
};
