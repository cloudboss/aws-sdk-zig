/// Contains information about the reason that the operation failed.
///
/// This data type is used as a response element in the
/// [GetOrganizationsAccessReport](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetOrganizationsAccessReport.html), [GetServiceLastAccessedDetails](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetServiceLastAccessedDetails.html), and [GetServiceLastAccessedDetailsWithEntities](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetServiceLastAccessedDetailsWithEntities.html) operations.
pub const ErrorDetails = struct {
    /// The error code associated with the operation failure.
    code: []const u8,

    /// Detailed information about the reason that the operation failed.
    message: []const u8,
};
