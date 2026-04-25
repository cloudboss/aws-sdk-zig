const MediaConnectRouterOutputConnectionMap = @import("media_connect_router_output_connection_map.zig").MediaConnectRouterOutputConnectionMap;
const MediaConnectRouterContainerSettings = @import("media_connect_router_container_settings.zig").MediaConnectRouterContainerSettings;
const OutputLocationRef = @import("output_location_ref.zig").OutputLocationRef;

/// Media Connect Router Output Settings
pub const MediaConnectRouterOutputSettings = struct {
    /// Shows the MediaConnect Router Inputs that are connected to this output. This
    /// parameter is purely informative, and editing it will have no effect. To
    /// connect or disconnect MediaConnect Router Inputs, go to MediaConnect.
    connected_router_inputs: ?MediaConnectRouterOutputConnectionMap = null,

    container_settings: MediaConnectRouterContainerSettings,

    /// Destination for this MediaConnect Router Output. The referenced
    /// OutputDestination must have MediaConnect Router settings configured.
    destination: OutputLocationRef,

    pub const json_field_names = .{
        .connected_router_inputs = "ConnectedRouterInputs",
        .container_settings = "ContainerSettings",
        .destination = "Destination",
    };
};
