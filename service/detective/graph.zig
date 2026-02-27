/// A behavior graph in Detective.
pub const Graph = struct {
    /// The ARN of the behavior graph.
    arn: ?[]const u8,

    /// The date and time that the behavior graph was created. The value is an
    /// ISO8601 formatted
    /// string. For example, `2021-08-18T16:35:56.284Z`.
    created_time: ?i64,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_time = "CreatedTime",
    };
};
