const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;
const DashboardCustomizationStatus = @import("dashboard_customization_status.zig").DashboardCustomizationStatus;

/// The configuration that controls field customization options available to
/// dashboard readers for a visual.
pub const VisualCustomizationFieldsConfiguration = struct {
    /// The additional dataset fields available for dashboard readers to customize
    /// the visual with, beyond the fields already configured on the visual.
    additional_fields: ?[]const ColumnIdentifier,

    /// Specifies whether dashboard readers can customize fields for this visual.
    /// This option is `ENABLED` by default.
    status: ?DashboardCustomizationStatus,

    pub const json_field_names = .{
        .additional_fields = "AdditionalFields",
        .status = "Status",
    };
};
