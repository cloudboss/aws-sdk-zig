const aws = @import("aws");

const AwsApiCallActionDomainDetails = @import("aws_api_call_action_domain_details.zig").AwsApiCallActionDomainDetails;
const ActionRemoteIpDetails = @import("action_remote_ip_details.zig").ActionRemoteIpDetails;

/// Provided if `ActionType` is `AWS_API_CALL`. It provides details
/// about the API call that was detected.
pub const AwsApiCallAction = struct {
    /// Identifies the resources that were affected by the API call.
    affected_resources: ?[]const aws.map.StringMapEntry,

    /// The name of the API method that was issued.
    ///
    /// Length Constraints: 128.
    api: ?[]const u8,

    /// Indicates whether the API call originated from a remote IP address
    /// (`remoteip`) or from a DNS domain (`domain`).
    caller_type: ?[]const u8,

    /// Provided if `CallerType` is `domain`. Provides information about
    /// the DNS domain that the API call originated from.
    domain_details: ?AwsApiCallActionDomainDetails,

    /// A timestamp that indicates when the API call was first
    /// observed.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    first_seen: ?[]const u8,

    /// A timestamp that indicates when the API call was most recently
    /// observed.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    last_seen: ?[]const u8,

    /// Provided if `CallerType` is `remoteip`. Provides information about
    /// the remote IP address that the API call originated from.
    remote_ip_details: ?ActionRemoteIpDetails,

    /// The name of the Amazon Web Services service that the API method belongs to.
    ///
    /// Length Constraints: 128.
    service_name: ?[]const u8,

    pub const json_field_names = .{
        .affected_resources = "AffectedResources",
        .api = "Api",
        .caller_type = "CallerType",
        .domain_details = "DomainDetails",
        .first_seen = "FirstSeen",
        .last_seen = "LastSeen",
        .remote_ip_details = "RemoteIpDetails",
        .service_name = "ServiceName",
    };
};
