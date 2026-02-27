const AlertManagerDefinitionStatus = @import("alert_manager_definition_status.zig").AlertManagerDefinitionStatus;

/// The details of an alert manager definition. It is the configuration for the
/// alert manager, including information about receivers for routing alerts.
pub const AlertManagerDefinitionDescription = struct {
    /// The date and time that the alert manager definition was created.
    created_at: i64,

    /// The actual alert manager definition.
    ///
    /// For details about the alert manager definition, see
    /// [AlertManagedDefinitionData](https://docs.aws.amazon.com/prometheus/latest/APIReference/yaml-AlertManagerDefinitionData.html).
    data: []const u8,

    /// The date and time that the alert manager definition was most recently
    /// changed.
    modified_at: i64,

    /// A structure that displays the current status of the alert manager
    /// definition..
    status: AlertManagerDefinitionStatus,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .data = "data",
        .modified_at = "modifiedAt",
        .status = "status",
    };
};
