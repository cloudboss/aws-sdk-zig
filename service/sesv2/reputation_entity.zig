const StatusRecord = @import("status_record.zig").StatusRecord;
const ReputationEntityType = @import("reputation_entity_type.zig").ReputationEntityType;
const RecommendationImpact = @import("recommendation_impact.zig").RecommendationImpact;
const SendingStatus = @import("sending_status.zig").SendingStatus;

/// An object that contains information about a reputation entity, including its
/// reference, type, policy, status records, and reputation impact.
pub const ReputationEntity = struct {
    /// The Amazon Web Services Amazon SES-managed status record for this reputation
    /// entity, including the
    /// current status, cause description, and last updated timestamp.
    aws_ses_managed_status: ?StatusRecord = null,

    /// The customer-managed status record for this reputation entity, including the
    /// current status, cause description, and last updated timestamp.
    customer_managed_status: ?StatusRecord = null,

    /// The unique identifier for the reputation entity. For resource-type entities,
    /// this is the Amazon Resource Name (ARN) of the resource.
    reputation_entity_reference: ?[]const u8 = null,

    /// The type of reputation entity. Currently, only `RESOURCE` type entities are
    /// supported.
    reputation_entity_type: ?ReputationEntityType = null,

    /// The reputation impact level for this entity, representing the highest impact
    /// reputation finding currently active. Reputation findings can be retrieved
    /// using
    /// the `ListRecommendations` operation.
    reputation_impact: ?RecommendationImpact = null,

    /// The Amazon Resource Name (ARN) of the reputation management policy applied
    /// to
    /// this entity. This is an Amazon Web Services Amazon SES-managed policy.
    reputation_management_policy: ?[]const u8 = null,

    /// The aggregate sending status that determines whether the entity is allowed
    /// to
    /// send emails. This status is derived from both the customer-managed and
    /// Amazon Web Services Amazon SES-managed
    /// statuses. If either the customer-managed status or the Amazon Web Services
    /// Amazon SES-managed status is
    /// `DISABLED`, the aggregate status will be `DISABLED` and the entity
    /// will not be allowed to send emails. When the customer-managed status is set
    /// to
    /// `REINSTATED`, the entity can continue sending even if there are active
    /// reputation findings, provided the Amazon Web Services Amazon SES-managed
    /// status also permits sending.
    /// The entity can only send emails when both statuses permit sending.
    sending_status_aggregate: ?SendingStatus = null,

    pub const json_field_names = .{
        .aws_ses_managed_status = "AwsSesManagedStatus",
        .customer_managed_status = "CustomerManagedStatus",
        .reputation_entity_reference = "ReputationEntityReference",
        .reputation_entity_type = "ReputationEntityType",
        .reputation_impact = "ReputationImpact",
        .reputation_management_policy = "ReputationManagementPolicy",
        .sending_status_aggregate = "SendingStatusAggregate",
    };
};
