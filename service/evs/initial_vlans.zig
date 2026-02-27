const InitialVlanInfo = @import("initial_vlan_info.zig").InitialVlanInfo;

/// The initial VLAN subnets for the environment. Amazon EVS VLAN subnets have a
/// minimum CIDR block size of /28 and a maximum size of /24. Amazon EVS VLAN
/// subnet CIDR blocks must not overlap with other subnets in the VPC.
pub const InitialVlans = struct {
    /// The edge VTEP VLAN subnet. This VLAN subnet manages traffic flowing between
    /// the internal network and external networks, including internet access and
    /// other site connections.
    edge_v_tep: InitialVlanInfo,

    /// An additional VLAN subnet that can be used to extend VCF capabilities once
    /// configured. For example, you can configure an expansion VLAN subnet to use
    /// NSX Federation for centralized management and synchronization of multiple
    /// NSX deployments across different locations.
    expansion_vlan_1: InitialVlanInfo,

    /// An additional VLAN subnet that can be used to extend VCF capabilities once
    /// configured. For example, you can configure an expansion VLAN subnet to use
    /// NSX Federation for centralized management and synchronization of multiple
    /// NSX deployments across different locations.
    expansion_vlan_2: InitialVlanInfo,

    /// The HCX VLAN subnet. This VLAN subnet allows the HCX Interconnnect (IX) and
    /// HCX Network Extension (NE) to reach their peers and enable HCX Service Mesh
    /// creation.
    ///
    /// If you plan to use a public HCX VLAN subnet, the following requirements must
    /// be met:
    ///
    /// * Must have a /28 netmask and be allocated from the IPAM public pool.
    ///   Required for HCX internet access configuration.
    /// * The HCX public VLAN CIDR block must be added to the VPC as a secondary
    ///   CIDR block.
    /// * Must have at least two Elastic IP addresses to be allocated from the
    ///   public IPAM pool for HCX components.
    hcx: InitialVlanInfo,

    /// A unique ID for a network access control list that the HCX VLAN uses.
    /// Required when `isHcxPublic` is set to `true`.
    hcx_network_acl_id: ?[]const u8,

    /// Determines if the HCX VLAN that Amazon EVS provisions is public or private.
    is_hcx_public: bool = false,

    /// The NSX uplink VLAN subnet. This VLAN subnet allows connectivity to the NSX
    /// overlay network.
    nsx_uplink: InitialVlanInfo,

    /// The host VMkernel management VLAN subnet. This VLAN subnet carries traffic
    /// for managing ESX hosts and communicating with VMware vCenter Server.
    vmk_management: InitialVlanInfo,

    /// The VM management VLAN subnet. This VLAN subnet carries traffic for vSphere
    /// virtual machines.
    vm_management: InitialVlanInfo,

    /// The vMotion VLAN subnet. This VLAN subnet carries traffic for vSphere
    /// vMotion.
    v_motion: InitialVlanInfo,

    /// The vSAN VLAN subnet. This VLAN subnet carries the communication between ESX
    /// hosts to implement a vSAN shared storage pool.
    v_san: InitialVlanInfo,

    /// The VTEP VLAN subnet. This VLAN subnet handles internal network traffic
    /// between virtual machines within a VCF instance.
    v_tep: InitialVlanInfo,

    pub const json_field_names = .{
        .edge_v_tep = "edgeVTep",
        .expansion_vlan_1 = "expansionVlan1",
        .expansion_vlan_2 = "expansionVlan2",
        .hcx = "hcx",
        .hcx_network_acl_id = "hcxNetworkAclId",
        .is_hcx_public = "isHcxPublic",
        .nsx_uplink = "nsxUplink",
        .vmk_management = "vmkManagement",
        .vm_management = "vmManagement",
        .v_motion = "vMotion",
        .v_san = "vSan",
        .v_tep = "vTep",
    };
};
