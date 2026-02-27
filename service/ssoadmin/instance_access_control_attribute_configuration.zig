const AccessControlAttribute = @import("access_control_attribute.zig").AccessControlAttribute;

/// Specifies the attributes to add to your attribute-based access control
/// (ABAC) configuration.
pub const InstanceAccessControlAttributeConfiguration = struct {
    /// Lists the attributes that are configured for ABAC in the specified IAM
    /// Identity Center instance.
    access_control_attributes: []const AccessControlAttribute,

    pub const json_field_names = .{
        .access_control_attributes = "AccessControlAttributes",
    };
};
