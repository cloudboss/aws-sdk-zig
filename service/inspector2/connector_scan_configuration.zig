const ConnectorContainerImageScanConfiguration = @import("connector_container_image_scan_configuration.zig").ConnectorContainerImageScanConfiguration;

/// The scan settings that Amazon Inspector applies to resources discovered
/// through a connector.
pub const ConnectorScanConfiguration = struct {
    /// The container image scanning configuration, including push and pull duration
    /// settings.
    container_image_scanning: ?ConnectorContainerImageScanConfiguration = null,

    pub const json_field_names = .{
        .container_image_scanning = "containerImageScanning",
    };
};
