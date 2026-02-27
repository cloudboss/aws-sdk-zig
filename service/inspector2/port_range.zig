/// Details about the port range associated with a finding.
pub const PortRange = struct {
    /// The beginning port in a port range.
    begin: i32,

    /// The ending port in a port range.
    end: i32,

    pub const json_field_names = .{
        .begin = "begin",
        .end = "end",
    };
};
