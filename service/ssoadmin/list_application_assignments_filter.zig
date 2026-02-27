/// A structure that describes a filter for application assignments.
pub const ListApplicationAssignmentsFilter = struct {
    /// The ARN of an application.
    application_arn: ?[]const u8,

    pub const json_field_names = .{
        .application_arn = "ApplicationArn",
    };
};
