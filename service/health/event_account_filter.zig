/// The values used to filter results from the
/// [DescribeEventDetailsForOrganization](https://docs.aws.amazon.com/health/latest/APIReference/API_DescribeEventDetailsForOrganization.html) and [DescribeAffectedEntitiesForOrganization](https://docs.aws.amazon.com/health/latest/APIReference/API_DescribeAffectedEntitiesForOrganization.html) operations.
pub const EventAccountFilter = struct {
    /// The 12-digit Amazon Web Services account numbers that contains the affected
    /// entities.
    aws_account_id: ?[]const u8,

    /// The unique identifier for the event. The event ARN has the
    /// `arn:aws:health:*event-region*::event/*SERVICE*/*EVENT_TYPE_CODE*/*EVENT_TYPE_PLUS_ID*
    /// `
    /// format.
    ///
    /// For example, an event ARN might look like the following:
    ///
    /// `arn:aws:health:us-east-1::event/EC2/EC2_INSTANCE_RETIREMENT_SCHEDULED/EC2_INSTANCE_RETIREMENT_SCHEDULED_ABC123-DEF456`
    event_arn: []const u8,

    pub const json_field_names = .{
        .aws_account_id = "awsAccountId",
        .event_arn = "eventArn",
    };
};
