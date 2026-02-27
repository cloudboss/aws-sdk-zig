/// The Spark Amazon Web Services Glue args.
pub const SparkGlueArgs = struct {
    /// The connection in the Spark Amazon Web Services Glue args.
    connection: ?[]const u8,

    pub const json_field_names = .{
        .connection = "connection",
    };
};
