/// Describes a range of ports.
pub const PortRange = struct {
    /// The first port in the range.
    from: ?i32,

    /// The last port in the range.
    to: ?i32,
};
