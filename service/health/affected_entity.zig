const aws = @import("aws");

const entityStatusCode = @import("entity_status_code.zig").entityStatusCode;

/// Information about an entity that is affected by a Health event.
pub const AffectedEntity = struct {
    /// The 12-digit Amazon Web Services account number that contains the affected
    /// entity.
    aws_account_id: ?[]const u8,

    /// The unique identifier for the entity. Format:
    /// `arn:aws:health:*entity-region*:*aws-account*:entity/*entity-id*
    /// `. Example:
    /// `arn:aws:health:us-east-1:111222333444:entity/AVh5GGT7ul1arKr1sE1K`
    entity_arn: ?[]const u8,

    /// Additional metadata about the affected entity.
    entity_metadata: ?[]const aws.map.StringMapEntry,

    /// The URL of the affected entity.
    entity_url: ?[]const u8,

    /// The ID of the affected entity.
    entity_value: ?[]const u8,

    /// The unique identifier for the event. The event ARN has the
    /// `arn:aws:health:*event-region*::event/*SERVICE*/*EVENT_TYPE_CODE*/*EVENT_TYPE_PLUS_ID*
    /// `
    /// format.
    ///
    /// For example, an event ARN might look like the following:
    ///
    /// `arn:aws:health:us-east-1::event/EC2/EC2_INSTANCE_RETIREMENT_SCHEDULED/EC2_INSTANCE_RETIREMENT_SCHEDULED_ABC123-DEF456`
    event_arn: ?[]const u8,

    /// The most recent time that the entity was updated.
    last_updated_time: ?i64,

    /// The most recent status of the entity affected by the event. The possible
    /// values are
    /// `IMPAIRED`, `UNIMPAIRED`, `UNKNOWN`, `PENDING`, and `RESOLVED`.
    status_code: ?entityStatusCode,

    /// A map of entity tags attached to the affected entity.
    ///
    /// Currently, the `tags` property isn't supported.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .aws_account_id = "awsAccountId",
        .entity_arn = "entityArn",
        .entity_metadata = "entityMetadata",
        .entity_url = "entityUrl",
        .entity_value = "entityValue",
        .event_arn = "eventArn",
        .last_updated_time = "lastUpdatedTime",
        .status_code = "statusCode",
        .tags = "tags",
    };
};
