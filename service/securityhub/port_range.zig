/// A range of ports.
pub const PortRange = struct {
    /// The first port in the port range.
    begin: ?i32 = null,

    /// The last port in the port range.
    end: ?i32 = null,

    pub const json_field_names = .{
        .begin = "Begin",
        .end = "End",
    };
};
