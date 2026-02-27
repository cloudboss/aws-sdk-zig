/// The method used to distribute log data to the destination, which can be
/// either random
/// or grouped by log stream.
pub const Distribution = enum {
    random,
    by_log_stream,

    pub const json_field_names = .{
        .random = "Random",
        .by_log_stream = "ByLogStream",
    };
};
