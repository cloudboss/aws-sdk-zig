/// Error information returned when a
/// [DescribeEventDetailsForOrganization](https://docs.aws.amazon.com/health/latest/APIReference/API_DescribeEventDetailsForOrganization.html) operation can't find a specified
/// event.
pub const OrganizationEventDetailsErrorItem = struct {
    /// Error information returned when a
    /// [DescribeEventDetailsForOrganization](https://docs.aws.amazon.com/health/latest/APIReference/API_DescribeEventDetailsForOrganization.html) operation can't find a specified
    /// event.
    aws_account_id: ?[]const u8,

    /// A message that describes the error.
    ///
    /// If you call the `DescribeEventDetailsForOrganization` operation and receive
    /// one of the following errors, follow the recommendations in the message:
    ///
    /// * We couldn't find a public event that matches your request. To find an
    ///   event that is account specific, you must enter an Amazon Web Services
    ///   account ID in the request.
    ///
    /// * We couldn't find an account specific event for the specified Amazon Web
    ///   Services account. To find an event that is public, you must enter a null
    ///   value for the Amazon Web Services account ID in the request.
    ///
    /// * Your Amazon Web Services account doesn't include the Amazon Web Services
    ///   Support plan required to use the
    /// Health API. You must have either a Business, Enterprise On-Ramp, or
    /// Enterprise Support plan.
    error_message: ?[]const u8,

    /// The name of the error.
    error_name: ?[]const u8,

    /// The unique identifier for the event. The event ARN has the
    /// `arn:aws:health:*event-region*::event/*SERVICE*/*EVENT_TYPE_CODE*/*EVENT_TYPE_PLUS_ID*
    /// `
    /// format.
    ///
    /// For example, an event ARN might look like the following:
    ///
    /// `arn:aws:health:us-east-1::event/EC2/EC2_INSTANCE_RETIREMENT_SCHEDULED/EC2_INSTANCE_RETIREMENT_SCHEDULED_ABC123-DEF456`
    event_arn: ?[]const u8,

    pub const json_field_names = .{
        .aws_account_id = "awsAccountId",
        .error_message = "errorMessage",
        .error_name = "errorName",
        .event_arn = "eventArn",
    };
};
