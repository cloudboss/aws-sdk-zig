/// The DNS hostnames that Amazon EVS uses to install VMware vCenter Server,
/// NSX, SDDC Manager, and Cloud Builder. Each hostname must be unique, and
/// resolve to a domain name that you've registered in your DNS service of
/// choice. Hostnames cannot be changed.
///
/// VMware VCF requires the deployment of two NSX Edge nodes, and three NSX
/// Manager virtual machines.
pub const VcfHostnames = struct {
    /// The hostname for VMware Cloud Builder.
    cloud_builder: []const u8,

    /// The VMware NSX hostname.
    nsx: []const u8,

    /// The hostname for the first NSX Edge node.
    nsx_edge_1: []const u8,

    /// The hostname for the second NSX Edge node.
    nsx_edge_2: []const u8,

    /// The hostname for the first VMware NSX Manager virtual machine (VM).
    nsx_manager_1: []const u8,

    /// The hostname for the second VMware NSX Manager virtual machine (VM).
    nsx_manager_2: []const u8,

    /// The hostname for the third VMware NSX Manager virtual machine (VM).
    nsx_manager_3: []const u8,

    /// The hostname for SDDC Manager.
    sddc_manager: []const u8,

    /// The VMware vCenter hostname.
    v_center: []const u8,

    pub const json_field_names = .{
        .cloud_builder = "cloudBuilder",
        .nsx = "nsx",
        .nsx_edge_1 = "nsxEdge1",
        .nsx_edge_2 = "nsxEdge2",
        .nsx_manager_1 = "nsxManager1",
        .nsx_manager_2 = "nsxManager2",
        .nsx_manager_3 = "nsxManager3",
        .sddc_manager = "sddcManager",
        .v_center = "vCenter",
    };
};
