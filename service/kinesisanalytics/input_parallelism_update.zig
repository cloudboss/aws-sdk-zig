/// Provides updates to the parallelism count.
pub const InputParallelismUpdate = struct {
    /// Number of in-application streams to create for the specified
    /// streaming source.
    count_update: ?i32 = null,

    pub const json_field_names = .{
        .count_update = "CountUpdate",
    };
};
