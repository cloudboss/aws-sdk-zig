const RecorderType = @import("recorder_type.zig").RecorderType;

/// Contains information about the service-linked recorder paired with a service
/// view.
pub const ServiceLinkedRecorderInfo = struct {
    /// The name of the service-linked recorder, such as
    /// `AWSConfigurationRecorderForObservabilityAdmin`.
    recorder_name: ?[]const u8 = null,

    /// The type of the recorder. Valid values are `AWS` and `THIRD_PARTY`.
    recorder_type: ?RecorderType = null,

    /// The service principal of the Amazon Web Services service that owns the
    /// service-linked recorder, such as `observabilityadmin.amazonaws.com`.
    service_principal: ?[]const u8 = null,

    pub const json_field_names = .{
        .recorder_name = "RecorderName",
        .recorder_type = "RecorderType",
        .service_principal = "ServicePrincipal",
    };
};
