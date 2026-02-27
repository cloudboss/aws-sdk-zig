/// The virtual private cloud (VPC) configuration for an access point.
pub const VpcConfiguration = struct {
    /// If this field is specified, this access point will only allow connections
    /// from the specified VPC
    /// ID.
    vpc_id: []const u8,
};
