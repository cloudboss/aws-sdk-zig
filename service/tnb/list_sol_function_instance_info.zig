const GetSolInstantiatedVnfInfo = @import("get_sol_instantiated_vnf_info.zig").GetSolInstantiatedVnfInfo;
const VnfInstantiationState = @import("vnf_instantiation_state.zig").VnfInstantiationState;
const ListSolFunctionInstanceMetadata = @import("list_sol_function_instance_metadata.zig").ListSolFunctionInstanceMetadata;

/// Lists information about a network function instance.
///
/// A network function instance is a function in a function package .
pub const ListSolFunctionInstanceInfo = struct {
    /// Network function instance ARN.
    arn: []const u8,

    /// Network function instance ID.
    id: []const u8,

    instantiated_vnf_info: ?GetSolInstantiatedVnfInfo = null,

    /// Network function instance instantiation state.
    instantiation_state: VnfInstantiationState,

    /// Network function instance metadata.
    metadata: ListSolFunctionInstanceMetadata,

    /// Network instance ID.
    ns_instance_id: []const u8,

    /// Function package ID.
    vnf_pkg_id: []const u8,

    /// Function package name.
    vnf_pkg_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
        .instantiated_vnf_info = "instantiatedVnfInfo",
        .instantiation_state = "instantiationState",
        .metadata = "metadata",
        .ns_instance_id = "nsInstanceId",
        .vnf_pkg_id = "vnfPkgId",
        .vnf_pkg_name = "vnfPkgName",
    };
};
