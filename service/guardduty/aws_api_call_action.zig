const aws = @import("aws");

const DomainDetails = @import("domain_details.zig").DomainDetails;
const RemoteAccountDetails = @import("remote_account_details.zig").RemoteAccountDetails;
const RemoteIpDetails = @import("remote_ip_details.zig").RemoteIpDetails;

/// Contains information about the API action.
pub const AwsApiCallAction = struct {
    /// The details of the Amazon Web Services account that made the API call. This
    /// field identifies the
    /// resources that were affected by this API call.
    affected_resources: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Web Services API name.
    api: ?[]const u8 = null,

    /// The Amazon Web Services API caller type.
    caller_type: ?[]const u8 = null,

    /// The domain information for the Amazon Web Services API call.
    domain_details: ?DomainDetails = null,

    /// The error code of the failed Amazon Web Services API action.
    error_code: ?[]const u8 = null,

    /// The details of the Amazon Web Services account that made the API call. This
    /// field appears if the call
    /// was made from outside your account.
    remote_account_details: ?RemoteAccountDetails = null,

    /// The remote IP information of the connection that initiated the Amazon Web
    /// Services API call.
    remote_ip_details: ?RemoteIpDetails = null,

    /// The Amazon Web Services service name whose API was invoked.
    service_name: ?[]const u8 = null,

    /// The agent through which the API request was made.
    user_agent: ?[]const u8 = null,

    pub const json_field_names = .{
        .affected_resources = "AffectedResources",
        .api = "Api",
        .caller_type = "CallerType",
        .domain_details = "DomainDetails",
        .error_code = "ErrorCode",
        .remote_account_details = "RemoteAccountDetails",
        .remote_ip_details = "RemoteIpDetails",
        .service_name = "ServiceName",
        .user_agent = "UserAgent",
    };
};
