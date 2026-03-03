const InstanceMetadataEndpointState = @import("instance_metadata_endpoint_state.zig").InstanceMetadataEndpointState;
const HttpTokensState = @import("http_tokens_state.zig").HttpTokensState;
const InstanceMetadataTagsState = @import("instance_metadata_tags_state.zig").InstanceMetadataTagsState;
const ManagedBy = @import("managed_by.zig").ManagedBy;

/// The default instance metadata service (IMDS) settings that were set at the
/// account
/// level in the specified Amazon Web Services  Region.
pub const InstanceMetadataDefaultsResponse = struct {
    /// Indicates whether the IMDS endpoint for an instance is enabled or disabled.
    /// When disabled, the instance
    /// metadata can't be accessed.
    http_endpoint: ?InstanceMetadataEndpointState = null,

    /// The maximum number of hops that the metadata token can travel.
    http_put_response_hop_limit: ?i32 = null,

    /// Indicates whether IMDSv2 is required.
    ///
    /// * `optional` – IMDSv2 is optional, which means that you can
    /// use either IMDSv2 or IMDSv1.
    ///
    /// * `required` – IMDSv2 is required, which means that IMDSv1 is
    /// disabled, and you must use IMDSv2.
    http_tokens: ?HttpTokensState = null,

    /// Indicates whether access to instance tags from the instance metadata is
    /// enabled or
    /// disabled. For more information, see [Work with
    /// instance tags using the instance
    /// metadata](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html#work-with-tags-in-IMDS) in the
    /// *Amazon EC2 User Guide*.
    instance_metadata_tags: ?InstanceMetadataTagsState = null,

    /// The entity that manages the IMDS default settings. Possible values include:
    ///
    /// * `account` - The IMDS default settings are managed by the
    /// account.
    ///
    /// * `declarative-policy` - The IMDS default settings are managed
    /// by a declarative policy and can't be modified by the account.
    managed_by: ?ManagedBy = null,

    /// The customized exception message that is specified in the declarative
    /// policy.
    managed_exception_message: ?[]const u8 = null,
};
