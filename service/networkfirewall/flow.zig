const Address = @import("address.zig").Address;

/// Any number of arrays, where each array is a single flow identified in the
/// scope of the operation.
/// If multiple flows were in the scope of the operation, multiple `Flows`
/// arrays are returned.
pub const Flow = struct {
    /// Returned as info about age of the flows identified by the flow operation.
    age: ?i32 = null,

    /// Returns the number of bytes received or transmitted in a specific flow.
    byte_count: i64 = 0,

    destination_address: ?Address = null,

    /// The destination port to inspect for. You can specify an individual port,
    /// for example `1994` and you can specify a port range, for example
    /// `1990:1994`.
    /// To match with any port, specify `ANY`.
    destination_port: ?[]const u8 = null,

    /// Returns the total number of data packets received or transmitted in a flow.
    packet_count: ?i32 = null,

    /// The protocols to inspect for, specified using the assigned internet protocol
    /// number (IANA)
    /// for each protocol. If not specified, this matches with any protocol.
    protocol: ?[]const u8 = null,

    source_address: ?Address = null,

    /// The source port to inspect for. You can specify an individual port,
    /// for example `1994` and you can specify a port range, for example
    /// `1990:1994`.
    /// To match with any port, specify `ANY`.
    source_port: ?[]const u8 = null,

    pub const json_field_names = .{
        .age = "Age",
        .byte_count = "ByteCount",
        .destination_address = "DestinationAddress",
        .destination_port = "DestinationPort",
        .packet_count = "PacketCount",
        .protocol = "Protocol",
        .source_address = "SourceAddress",
        .source_port = "SourcePort",
    };
};
