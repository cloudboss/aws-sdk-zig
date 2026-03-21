const CodeInterpreterNetworkMode = @import("code_interpreter_network_mode.zig").CodeInterpreterNetworkMode;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

/// The network configuration for a code interpreter. This structure defines how
/// the code interpreter connects to the network.
pub const CodeInterpreterNetworkConfiguration = struct {
    /// The network mode for the code interpreter. This field specifies how the code
    /// interpreter connects to the network.
    network_mode: CodeInterpreterNetworkMode = .sandbox,

    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .network_mode = "networkMode",
        .vpc_config = "vpcConfig",
    };
};
