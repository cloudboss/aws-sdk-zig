const BrowserNetworkMode = @import("browser_network_mode.zig").BrowserNetworkMode;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

/// The network configuration for a browser. This structure defines how the
/// browser connects to the network.
pub const BrowserNetworkConfiguration = struct {
    /// The network mode for the browser. This field specifies how the browser
    /// connects to the network.
    network_mode: BrowserNetworkMode = .public,

    /// The VPC configuration for the browser. This configuration is required when
    /// the network mode is set to `VPC`.
    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .network_mode = "networkMode",
        .vpc_config = "vpcConfig",
    };
};
