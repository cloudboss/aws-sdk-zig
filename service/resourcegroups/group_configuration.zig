const GroupConfigurationItem = @import("group_configuration_item.zig").GroupConfigurationItem;
const GroupConfigurationStatus = @import("group_configuration_status.zig").GroupConfigurationStatus;

/// A service configuration associated with a resource group. The configuration
/// options
/// are determined by the Amazon Web Services service that defines the `Type`,
/// and specifies
/// which resources can be included in the group. You can add a service
/// configuration when
/// you create the group by using CreateGroup, or later by using the
/// PutGroupConfiguration operation. For details about group service
/// configuration syntax, see [Service configurations for resource
/// groups](https://docs.aws.amazon.com/ARG/latest/APIReference/about-slg.html).
pub const GroupConfiguration = struct {
    /// The configuration currently associated with the group and in effect.
    configuration: ?[]const GroupConfigurationItem,

    /// If present, the reason why a request to update the group configuration
    /// failed.
    failure_reason: ?[]const u8,

    /// If present, the new configuration that is in the process of being applied to
    /// the
    /// group.
    proposed_configuration: ?[]const GroupConfigurationItem,

    /// The current status of an attempt to update the group configuration.
    status: ?GroupConfigurationStatus,

    pub const json_field_names = .{
        .configuration = "Configuration",
        .failure_reason = "FailureReason",
        .proposed_configuration = "ProposedConfiguration",
        .status = "Status",
    };
};
