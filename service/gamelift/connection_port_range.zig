/// The set of port numbers to open on each instance in a container fleet.
/// Connection
/// ports are used by inbound traffic to connect with processes that are running
/// in
/// containers on the fleet.
pub const ConnectionPortRange = struct {
    /// Starting value for the port range.
    from_port: i32,

    /// Ending value for the port. Port numbers are end-inclusive. This value must
    /// be equal to
    /// or greater than `FromPort`.
    to_port: i32,

    pub const json_field_names = .{
        .from_port = "FromPort",
        .to_port = "ToPort",
    };
};
