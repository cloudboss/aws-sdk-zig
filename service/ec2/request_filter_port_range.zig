/// Describes a port range.
pub const RequestFilterPortRange = struct {
    /// The first port in the range.
    from_port: ?i32,

    /// The last port in the range.
    to_port: ?i32,
};
