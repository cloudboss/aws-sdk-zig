const ErrorCode = @import("error_code.zig").ErrorCode;

/// Information about the errors that are returned for each failed resource.
/// This
/// information can include `InternalServiceException` and
/// `InvalidParameterException` errors. It can also include any valid error
/// code returned by the Amazon Web Services service that hosts the resource
/// that the ARN key
/// represents.
///
/// The following are common error codes that you might receive from other
/// Amazon Web Services
/// services:
///
/// * **InternalServiceException** – This can
/// mean that the Resource Groups Tagging API didn't receive a response from
/// another Amazon Web Services service. It
/// can also mean that the resource type in the request is not supported by the
/// Resource Groups Tagging API. In these cases, it's safe to retry the request
/// and then call
/// [GetResources](https://docs.aws.amazon.com/resourcegroupstagging/latest/APIReference/API_GetResources.html) to verify the changes.
///
/// * **AccessDeniedException** – This can mean
/// that you need permission to call the tagging operations in the Amazon Web
/// Services service
/// that contains the resource. For example, to use the Resource Groups Tagging
/// API to tag a Amazon CloudWatch
/// alarm resource, you need permission to call both [
/// `TagResources`
/// ](https://docs.aws.amazon.com/resourcegroupstagging/latest/APIReference/API_TagResources.html)
/// *and*
/// [
/// `TagResource`
/// ](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_TagResource.html) in the CloudWatch API.
///
/// For more information on errors that are generated from other Amazon Web
/// Services services, see the
/// documentation for that service.
pub const FailureInfo = struct {
    /// The code of the common error. Valid values include
    /// `InternalServiceException`, `InvalidParameterException`, and
    /// any valid error code returned by the Amazon Web Services service that hosts
    /// the resource that you want
    /// to tag.
    error_code: ?ErrorCode,

    /// The message of the common error.
    error_message: ?[]const u8,

    /// The HTTP status code of the common error.
    status_code: i32 = 0,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .status_code = "StatusCode",
    };
};
