/// Contains VPC information for the CreateDirectory, CreateMicrosoftAD, or
/// CreateHybridAD operation.
pub const DirectoryVpcSettings = struct {
    /// The identifiers of the subnets for the directory servers. The two subnets
    /// must be in
    /// different Availability Zones. Directory Service creates a directory server
    /// and a DNS server in each of
    /// these subnets.
    subnet_ids: []const []const u8,

    /// The identifier of the VPC in which to create the directory.
    vpc_id: []const u8,

    pub const json_field_names = .{
        .subnet_ids = "SubnetIds",
        .vpc_id = "VpcId",
    };
};
