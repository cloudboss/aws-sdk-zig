/// Resource type, 'INPUT', 'OUTPUT', 'MULTIPLEX', or 'CHANNEL'
pub const ReservationResourceType = enum {
    input,
    output,
    multiplex,
    channel,

    pub const json_field_names = .{
        .input = "INPUT",
        .output = "OUTPUT",
        .multiplex = "MULTIPLEX",
        .channel = "CHANNEL",
    };
};
