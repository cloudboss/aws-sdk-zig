/// For a SQL-based Kinesis Data Analytics application, describes the number of
/// in-application streams to create for a given streaming source.
pub const InputParallelism = struct {
    /// The number of in-application streams to create.
    count: ?i32,

    pub const json_field_names = .{
        .count = "Count",
    };
};
