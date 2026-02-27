const ComponentType = @import("component_type.zig").ComponentType;

/// This is information about the component of your SAP application, such as Web
/// Dispatcher.
pub const ComponentInfo = struct {
    /// This string is the type of the component.
    ///
    /// Accepted value is `WD`.
    component_type: ComponentType,

    /// This is the Amazon EC2 instance on which your SAP component is running.
    ///
    /// Accepted values are alphanumeric.
    ec_2_instance_id: []const u8,

    /// This string is the SAP System ID of the component.
    ///
    /// Accepted values are alphanumeric.
    sid: []const u8,

    pub const json_field_names = .{
        .component_type = "ComponentType",
        .ec_2_instance_id = "Ec2InstanceId",
        .sid = "Sid",
    };
};
