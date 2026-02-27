const Resource = @import("resource.zig").Resource;
const Service = @import("service.zig").Service;

/// Contains information about the finding that is generated when abnormal or
/// suspicious
/// activity is detected.
pub const Finding = struct {
    /// The ID of the account in which the finding was generated.
    account_id: []const u8,

    /// The ARN of the finding.
    arn: []const u8,

    /// Amazon Resource Name (ARN) associated with the attack sequence finding.
    associated_attack_sequence_arn: ?[]const u8,

    /// The confidence score for the finding.
    confidence: ?f64,

    /// The time and date when the finding was created.
    created_at: []const u8,

    /// The description of the finding.
    description: ?[]const u8,

    /// The ID of the finding.
    id: []const u8,

    /// The partition associated with the finding.
    partition: ?[]const u8,

    /// The Region where the finding was generated. For findings generated
    /// from [Global Service
    /// Events](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-concepts.html#cloudtrail-concepts-global-service-events), the Region value in the finding might differ from the Region where
    /// GuardDuty identifies the potential threat. For more information,
    /// see [How GuardDuty
    /// handles Amazon Web Services CloudTrail global
    /// events](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty_data-sources.html#cloudtrail_global) in the *Amazon GuardDuty User Guide*.
    region: []const u8,

    resource: Resource,

    /// The version of the schema used for the finding.
    schema_version: []const u8,

    service: ?Service,

    /// The severity of the finding.
    severity: f64,

    /// The title of the finding.
    title: ?[]const u8,

    /// The type of finding.
    type: []const u8,

    /// The time and date when the finding was last updated.
    updated_at: []const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .arn = "Arn",
        .associated_attack_sequence_arn = "AssociatedAttackSequenceArn",
        .confidence = "Confidence",
        .created_at = "CreatedAt",
        .description = "Description",
        .id = "Id",
        .partition = "Partition",
        .region = "Region",
        .resource = "Resource",
        .schema_version = "SchemaVersion",
        .service = "Service",
        .severity = "Severity",
        .title = "Title",
        .type = "Type",
        .updated_at = "UpdatedAt",
    };
};
