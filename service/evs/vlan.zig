const EipAssociation = @import("eip_association.zig").EipAssociation;
const VlanState = @import("vlan_state.zig").VlanState;

/// The VLANs that Amazon EVS creates during environment creation.
pub const Vlan = struct {
    /// The availability zone of the VLAN.
    availability_zone: ?[]const u8 = null,

    /// The CIDR block of the VLAN. Amazon EVS VLAN subnets have a minimum CIDR
    /// block size of /28 and a maximum size of /24.
    cidr: ?[]const u8 = null,

    /// The date and time that the VLAN was created.
    created_at: ?i64 = null,

    /// An array of Elastic IP address associations.
    eip_associations: ?[]const EipAssociation = null,

    /// The VMware VCF traffic type that is carried over the VLAN. For example, a
    /// VLAN with a `functionName` of `hcx` is being used to carry VMware HCX
    /// traffic.
    function_name: ?[]const u8 = null,

    /// Determines if the VLAN that Amazon EVS provisions is public or private.
    is_public: ?bool = null,

    /// The date and time that the VLAN was modified.
    modified_at: ?i64 = null,

    /// A unique ID for a network access control list.
    network_acl_id: ?[]const u8 = null,

    /// The state details of the VLAN.
    state_details: ?[]const u8 = null,

    /// The unique ID of the VLAN subnet.
    subnet_id: ?[]const u8 = null,

    /// The unique ID of the VLAN.
    vlan_id: ?i32 = null,

    /// The state of the VLAN.
    vlan_state: ?VlanState = null,

    pub const json_field_names = .{
        .availability_zone = "availabilityZone",
        .cidr = "cidr",
        .created_at = "createdAt",
        .eip_associations = "eipAssociations",
        .function_name = "functionName",
        .is_public = "isPublic",
        .modified_at = "modifiedAt",
        .network_acl_id = "networkAclId",
        .state_details = "stateDetails",
        .subnet_id = "subnetId",
        .vlan_id = "vlanId",
        .vlan_state = "vlanState",
    };
};
