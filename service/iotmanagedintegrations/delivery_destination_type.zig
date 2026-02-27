pub const DeliveryDestinationType = enum {
    kinesis,

    pub const json_field_names = .{
        .kinesis = "KINESIS",
    };
};
