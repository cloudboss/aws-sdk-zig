/// The parameters for Spark.
pub const SparkParameters = struct {
    /// Host.
    host: []const u8,

    /// Port.
    port: i32,

    pub const json_field_names = .{
        .host = "Host",
        .port = "Port",
    };
};
