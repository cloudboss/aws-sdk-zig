const ConfigDetails = @import("config_details.zig").ConfigDetails;
const ConfigCapabilityType = @import("config_capability_type.zig").ConfigCapabilityType;

/// Dataflow details for the destination side.
pub const Destination = struct {
    /// Additional details for a `Config`, if type is dataflow endpoint or antenna
    /// demod decode.
    config_details: ?ConfigDetails,

    /// UUID of a `Config`.
    config_id: ?[]const u8,

    /// Type of a `Config`.
    config_type: ?ConfigCapabilityType,

    /// Region of a dataflow destination.
    dataflow_destination_region: ?[]const u8,

    pub const json_field_names = .{
        .config_details = "configDetails",
        .config_id = "configId",
        .config_type = "configType",
        .dataflow_destination_region = "dataflowDestinationRegion",
    };
};
