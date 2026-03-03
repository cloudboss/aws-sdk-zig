/// A complex type for a range of ports for a listener.
pub const PortRange = struct {
    /// The first port in the range of ports, inclusive.
    from_port: ?i32 = null,

    /// The last port in the range of ports, inclusive.
    to_port: ?i32 = null,

    pub const json_field_names = .{
        .from_port = "FromPort",
        .to_port = "ToPort",
    };
};
