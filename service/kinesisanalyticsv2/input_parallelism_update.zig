/// For a SQL-based Kinesis Data Analytics application, provides updates to the
/// parallelism count.
pub const InputParallelismUpdate = struct {
    /// The number of in-application streams to create for the specified streaming
    /// source.
    count_update: i32,

    pub const json_field_names = .{
        .count_update = "CountUpdate",
    };
};
