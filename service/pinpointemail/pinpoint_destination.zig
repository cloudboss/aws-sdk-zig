/// An object that defines a Amazon Pinpoint destination for email events. You
/// can use Amazon Pinpoint events
/// to create attributes in Amazon Pinpoint projects. You can use these
/// attributes to create segments
/// for your campaigns.
pub const PinpointDestination = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Pinpoint project that you want
    /// to send email
    /// events to.
    application_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_arn = "ApplicationArn",
    };
};
