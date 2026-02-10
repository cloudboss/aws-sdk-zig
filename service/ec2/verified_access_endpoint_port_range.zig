/// Describes a port range.
pub const VerifiedAccessEndpointPortRange = struct {
    /// The start of the port range.
    from_port: ?i32,

    /// The end of the port range.
    to_port: ?i32,
};
