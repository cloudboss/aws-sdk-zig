const Address = @import("address.zig").Address;

/// Defines the scope a flow operation. You can use up to 20 filters to
/// configure a single flow operation.
pub const FlowFilter = struct {
    destination_address: ?Address = null,

    /// The destination port to inspect for. You can specify an individual port,
    /// for example `1994` and you can specify a port range, for example
    /// `1990:1994`.
    /// To match with any port, specify `ANY`.
    destination_port: ?[]const u8 = null,

    /// The protocols to inspect for, specified using the assigned internet protocol
    /// number (IANA)
    /// for each protocol. If not specified, this matches with any protocol.
    protocols: ?[]const []const u8 = null,

    source_address: ?Address = null,

    /// The source port to inspect for. You can specify an individual port,
    /// for example `1994` and you can specify a port range, for example
    /// `1990:1994`.
    /// To match with any port, specify `ANY`.
    source_port: ?[]const u8 = null,

    pub const json_field_names = .{
        .destination_address = "DestinationAddress",
        .destination_port = "DestinationPort",
        .protocols = "Protocols",
        .source_address = "SourceAddress",
        .source_port = "SourcePort",
    };
};
