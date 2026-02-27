pub const ShipmentState = enum {
    received,
    returned,

    pub const json_field_names = .{
        .received = "RECEIVED",
        .returned = "RETURNED",
    };
};
