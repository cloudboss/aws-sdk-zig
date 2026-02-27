const IotTwinMakerSourceConfigurationFilter = @import("iot_twin_maker_source_configuration_filter.zig").IotTwinMakerSourceConfigurationFilter;

/// The metadata transfer job AWS IoT TwinMaker source configuration.
pub const IotTwinMakerSourceConfiguration = struct {
    /// The metadata transfer job AWS IoT TwinMaker source configuration filters.
    filters: ?[]const IotTwinMakerSourceConfigurationFilter,

    /// The IoT TwinMaker workspace.
    workspace: []const u8,

    pub const json_field_names = .{
        .filters = "filters",
        .workspace = "workspace",
    };
};
