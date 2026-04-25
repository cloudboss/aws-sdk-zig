const ConfigurationPolicyAssociationStatus = @import("configuration_policy_association_status.zig").ConfigurationPolicyAssociationStatus;
const AssociationType = @import("association_type.zig").AssociationType;
const TargetType = @import("target_type.zig").TargetType;

/// An object that contains the details of a configuration policy association
/// that’s returned in a
/// `ListConfigurationPolicyAssociations` request.
pub const ConfigurationPolicyAssociationSummary = struct {
    /// The current status of the association between the specified target and the
    /// configuration.
    association_status: ?ConfigurationPolicyAssociationStatus = null,

    /// The explanation for a `FAILED` value for `AssociationStatus`.
    association_status_message: ?[]const u8 = null,

    /// Indicates whether the association between the specified target and the
    /// configuration was directly applied by the
    /// Security Hub CSPM delegated administrator or inherited from a parent.
    association_type: ?AssociationType = null,

    /// The universally unique identifier (UUID) of the configuration policy.
    configuration_policy_id: ?[]const u8 = null,

    /// The identifier of the target account, organizational unit, or the root.
    target_id: ?[]const u8 = null,

    /// Specifies whether the target is an Amazon Web Services account,
    /// organizational unit, or the root.
    target_type: ?TargetType = null,

    /// The date and time, in UTC and ISO 8601 format, that the configuration policy
    /// association was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .association_status = "AssociationStatus",
        .association_status_message = "AssociationStatusMessage",
        .association_type = "AssociationType",
        .configuration_policy_id = "ConfigurationPolicyId",
        .target_id = "TargetId",
        .target_type = "TargetType",
        .updated_at = "UpdatedAt",
    };
};
