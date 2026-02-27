/// Details for the external events data used for model version training.
pub const ExternalEventsDetail = struct {
    /// The ARN of the role that provides Amazon Fraud Detector access to the data
    /// location.
    data_access_role_arn: []const u8,

    /// The Amazon S3 bucket location for the data.
    data_location: []const u8,

    pub const json_field_names = .{
        .data_access_role_arn = "dataAccessRoleArn",
        .data_location = "dataLocation",
    };
};
