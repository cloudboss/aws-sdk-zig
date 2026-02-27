pub const RecordingScope = enum {
    internal,
    paid,

    pub const json_field_names = .{
        .internal = "INTERNAL",
        .paid = "PAID",
    };
};
