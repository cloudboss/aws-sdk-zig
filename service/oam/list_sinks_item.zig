/// A structure that contains information about one of this monitoring account's
/// sinks.
pub const ListSinksItem = struct {
    /// The ARN of the sink.
    arn: ?[]const u8 = null,

    /// The random ID string that Amazon Web Services generated as part of the sink
    /// ARN.
    id: ?[]const u8 = null,

    /// The name of the sink.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .name = "Name",
    };
};
