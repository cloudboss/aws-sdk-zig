/// Error information returned when a
/// [DescribeAffectedEntitiesForOrganization](https://docs.aws.amazon.com/health/latest/APIReference/API_DescribeAffectedEntitiesForOrganization.html) operation can't find or process a
/// specific entity.
pub const OrganizationAffectedEntitiesErrorItem = struct {
    /// The 12-digit Amazon Web Services account numbers that contains the affected
    /// entities.
    aws_account_id: ?[]const u8 = null,

    /// A message that describes the error. Follow the error message and retry your
    /// request.
    ///
    /// For example, the `InvalidAccountInputError` error message appears if
    /// you call the `DescribeAffectedEntitiesForOrganization` operation and specify
    /// the
    /// `AccountSpecific` value for the `EventScopeCode` parameter, but
    /// don't specify an Amazon Web Services account.
    error_message: ?[]const u8 = null,

    /// The name of the error.
    error_name: ?[]const u8 = null,

    /// The unique identifier for the event. The event ARN has the
    /// `arn:aws:health:*event-region*::event/*SERVICE*/*EVENT_TYPE_CODE*/*EVENT_TYPE_PLUS_ID*
    /// `
    /// format.
    ///
    /// For example, an event ARN might look like the following:
    ///
    /// `arn:aws:health:us-east-1::event/EC2/EC2_INSTANCE_RETIREMENT_SCHEDULED/EC2_INSTANCE_RETIREMENT_SCHEDULED_ABC123-DEF456`
    event_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .aws_account_id = "awsAccountId",
        .error_message = "errorMessage",
        .error_name = "errorName",
        .event_arn = "eventArn",
    };
};
