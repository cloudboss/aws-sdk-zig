/// A range of ports.
pub const PortRangeFromTo = struct {
    /// The first port in the port range.
    from: ?i32,

    /// The last port in the port range.
    to: ?i32,

    pub const json_field_names = .{
        .from = "From",
        .to = "To",
    };
};
