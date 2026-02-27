/// A single port range specification. This is used for source and destination
/// port ranges
/// in the stateless rule MatchAttributes, `SourcePorts`, and
/// `DestinationPorts` settings.
pub const PortRange = struct {
    /// The lower limit of the port range. This must be less than or equal to the
    /// `ToPort` specification.
    from_port: i32 = 0,

    /// The upper limit of the port range. This must be greater than or equal to the
    /// `FromPort` specification.
    to_port: i32 = 0,

    pub const json_field_names = .{
        .from_port = "FromPort",
        .to_port = "ToPort",
    };
};
