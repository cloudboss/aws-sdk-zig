const ContactCenterSystemType = @import("contact_center_system_type.zig").ContactCenterSystemType;
const SessionBorderControllerType = @import("session_border_controller_type.zig").SessionBorderControllerType;

/// Contains information about an external systems configuration for a Voice
/// Connector.
pub const ExternalSystemsConfiguration = struct {
    /// The contact center system.
    contact_center_system_types: ?[]const ContactCenterSystemType = null,

    /// The session border controllers.
    session_border_controller_types: ?[]const SessionBorderControllerType = null,

    pub const json_field_names = .{
        .contact_center_system_types = "ContactCenterSystemTypes",
        .session_border_controller_types = "SessionBorderControllerTypes",
    };
};
