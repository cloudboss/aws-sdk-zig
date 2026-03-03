const NdiDiscoveryServerConfig = @import("ndi_discovery_server_config.zig").NdiDiscoveryServerConfig;
const NdiState = @import("ndi_state.zig").NdiState;

/// Specifies the configuration settings for NDI sources and outputs.
pub const NdiConfig = struct {
    /// A prefix for the names of the NDI sources that the flow creates. If a custom
    /// name isn't specified, MediaConnect generates a unique 12-character ID as the
    /// prefix.
    machine_name: ?[]const u8 = null,

    /// A list of up to three NDI discovery server configurations. While not
    /// required by the API, this configuration is necessary for NDI functionality
    /// to work properly.
    ndi_discovery_servers: ?[]const NdiDiscoveryServerConfig = null,

    /// A setting that controls whether NDI® sources or outputs can be used in the
    /// flow.
    ///
    /// The default value is `DISABLED`. This value must be set as `ENABLED` for
    /// your flow to support NDI sources or outputs.
    ndi_state: ?NdiState = null,

    pub const json_field_names = .{
        .machine_name = "MachineName",
        .ndi_discovery_servers = "NdiDiscoveryServers",
        .ndi_state = "NdiState",
    };
};
