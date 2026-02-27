const GetSolVnfcResourceInfo = @import("get_sol_vnfc_resource_info.zig").GetSolVnfcResourceInfo;
const VnfOperationalState = @import("vnf_operational_state.zig").VnfOperationalState;

/// Information about the network function.
///
/// A network function instance is a function in a function package .
pub const GetSolVnfInfo = struct {
    /// Compute info used by the network function instance.
    vnfc_resource_info: ?[]const GetSolVnfcResourceInfo,

    /// State of the network function instance.
    vnf_state: ?VnfOperationalState,

    pub const json_field_names = .{
        .vnfc_resource_info = "vnfcResourceInfo",
        .vnf_state = "vnfState",
    };
};
