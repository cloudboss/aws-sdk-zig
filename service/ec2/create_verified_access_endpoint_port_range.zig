/// Describes the port range for a Verified Access endpoint.
pub const CreateVerifiedAccessEndpointPortRange = struct {
    /// The start of the port range.
    from_port: ?i32,

    /// The end of the port range.
    to_port: ?i32,
};
