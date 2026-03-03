const PrimaryAttributeAccessControlConfigurationItem = @import("primary_attribute_access_control_configuration_item.zig").PrimaryAttributeAccessControlConfigurationItem;

/// A data table access control configuration.
pub const DataTableAccessControlConfiguration = struct {
    /// The configuration's primary attribute access control configuration.
    primary_attribute_access_control_configuration: ?PrimaryAttributeAccessControlConfigurationItem = null,

    pub const json_field_names = .{
        .primary_attribute_access_control_configuration = "PrimaryAttributeAccessControlConfiguration",
    };
};
