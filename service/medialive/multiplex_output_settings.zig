const MultiplexContainerSettings = @import("multiplex_container_settings.zig").MultiplexContainerSettings;
const OutputLocationRef = @import("output_location_ref.zig").OutputLocationRef;

/// Multiplex Output Settings
pub const MultiplexOutputSettings = struct {
    container_settings: ?MultiplexContainerSettings,

    /// Destination is a Multiplex.
    destination: OutputLocationRef,

    pub const json_field_names = .{
        .container_settings = "ContainerSettings",
        .destination = "Destination",
    };
};
