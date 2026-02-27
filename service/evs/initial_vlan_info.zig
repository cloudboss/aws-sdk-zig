/// An object that represents an initial VLAN subnet for the Amazon EVS
/// environment. Amazon EVS creates initial VLAN subnets when you first create
/// the environment. Amazon EVS creates the following 10 VLAN subnets: host
/// management VLAN, vMotion VLAN, vSAN VLAN, VTEP VLAN, Edge VTEP VLAN,
/// Management VM VLAN, HCX uplink VLAN, NSX uplink VLAN, expansion VLAN 1,
/// expansion VLAN 2.
///
/// For each Amazon EVS VLAN subnet, you must specify a non-overlapping CIDR
/// block. Amazon EVS VLAN subnets have a minimum CIDR block size of /28 and a
/// maximum size of /24.
pub const InitialVlanInfo = struct {
    /// The CIDR block that you provide to create an Amazon EVS VLAN subnet. Amazon
    /// EVS VLAN subnets have a minimum CIDR block size of /28 and a maximum size of
    /// /24. Amazon EVS VLAN subnet CIDR blocks must not overlap with other subnets
    /// in the VPC.
    cidr: []const u8,

    pub const json_field_names = .{
        .cidr = "cidr",
    };
};
