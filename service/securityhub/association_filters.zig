const ConfigurationPolicyAssociationStatus = @import("configuration_policy_association_status.zig").ConfigurationPolicyAssociationStatus;
const AssociationType = @import("association_type.zig").AssociationType;

/// Options for filtering the `ListConfigurationPolicyAssociations` response.
/// You can filter by the Amazon Resource Name (ARN) or
/// universally unique identifier (UUID) of a configuration policy,
/// `AssociationType`, or `AssociationStatus`.
pub const AssociationFilters = struct {
    /// The current status of the association between a target and a configuration
    /// policy.
    association_status: ?ConfigurationPolicyAssociationStatus,

    /// Indicates whether the association between a target and a configuration was
    /// directly applied by the
    /// Security Hub delegated administrator or inherited from a parent.
    association_type: ?AssociationType,

    /// The ARN or UUID of the configuration policy.
    configuration_policy_id: ?[]const u8,

    pub const json_field_names = .{
        .association_status = "AssociationStatus",
        .association_type = "AssociationType",
        .configuration_policy_id = "ConfigurationPolicyId",
    };
};
