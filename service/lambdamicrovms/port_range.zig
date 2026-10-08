/// Specifies a range of ports.
pub const PortRange = struct {
    /// The ending port number of the range.
    end_port: i32,

    /// The starting port number of the range.
    start_port: i32,

    pub const json_field_names = .{
        .end_port = "endPort",
        .start_port = "startPort",
    };
};
