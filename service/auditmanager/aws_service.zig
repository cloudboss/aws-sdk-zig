/// An Amazon Web Services service such as Amazon S3 or CloudTrail.
///
/// For an example of how to find an Amazon Web Services service name and how to
/// define it in
/// your assessment scope, see the following:
///
/// * [Finding an Amazon Web Services service name to use in your assessment
///   scope](https://docs.aws.amazon.com/audit-manager/latest/APIReference/API_GetServicesInScope.html#API_GetServicesInScope_Example_2)
///
/// * [Defining an Amazon Web Services service name in your assessment
///   scope](https://docs.aws.amazon.com/audit-manager/latest/APIReference/API_GetServicesInScope.html#API_GetServicesInScope_Example_3)
pub const AWSService = struct {
    /// The name of the Amazon Web Services service.
    service_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .service_name = "serviceName",
    };
};
