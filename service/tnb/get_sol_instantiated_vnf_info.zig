const VnfOperationalState = @import("vnf_operational_state.zig").VnfOperationalState;

/// Information about a network function.
///
/// A network instance is a single network created in Amazon Web Services TNB
/// that can be deployed and on which life-cycle operations (like terminate,
/// update, and delete) can be performed.
pub const GetSolInstantiatedVnfInfo = struct {
    /// State of the network function.
    vnf_state: ?VnfOperationalState = null,

    pub const json_field_names = .{
        .vnf_state = "vnfState",
    };
};
