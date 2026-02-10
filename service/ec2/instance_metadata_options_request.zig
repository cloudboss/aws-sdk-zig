const InstanceMetadataEndpointState = @import("instance_metadata_endpoint_state.zig").InstanceMetadataEndpointState;
const InstanceMetadataProtocolState = @import("instance_metadata_protocol_state.zig").InstanceMetadataProtocolState;
const HttpTokensState = @import("http_tokens_state.zig").HttpTokensState;
const InstanceMetadataTagsState = @import("instance_metadata_tags_state.zig").InstanceMetadataTagsState;

/// The metadata options for the instance.
pub const InstanceMetadataOptionsRequest = struct {
    /// Enables or disables the HTTP metadata endpoint on your instances.
    ///
    /// If you specify a value of `disabled`, you cannot access your instance
    /// metadata.
    ///
    /// Default: `enabled`
    http_endpoint: ?InstanceMetadataEndpointState,

    /// Enables or disables the IPv6 endpoint for the instance metadata service.
    ///
    /// Default: `disabled`
    http_protocol_ipv_6: ?InstanceMetadataProtocolState,

    /// The maximum number of hops that the metadata token can travel.
    ///
    /// Possible values: Integers from 1 to 64
    http_put_response_hop_limit: ?i32,

    /// Indicates whether IMDSv2 is required.
    ///
    /// * `optional` - IMDSv2 is optional, which means that you can use
    /// either IMDSv2 or IMDSv1.
    ///
    /// * `required` - IMDSv2 is required, which means that IMDSv1 is
    /// disabled, and you must use IMDSv2.
    ///
    /// Default:
    ///
    /// * If the value of `ImdsSupport` for the Amazon Machine Image (AMI)
    /// for your instance is `v2.0` and the account level default is set to
    /// `no-preference`, the default is `required`.
    ///
    /// * If the value of `ImdsSupport` for the Amazon Machine Image (AMI)
    /// for your instance is `v2.0`, but the account level default is set to
    /// `V1 or V2`, the default is `optional`.
    ///
    /// The default value can also be affected by other combinations of parameters.
    /// For more
    /// information, see [Order of precedence for instance metadata
    /// options](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configuring-instance-metadata-options.html#instance-metadata-options-order-of-precedence) in the
    /// *Amazon EC2 User Guide*.
    http_tokens: ?HttpTokensState,

    /// Set to `enabled` to allow access to instance tags from the instance
    /// metadata. Set to `disabled` to turn off access to instance tags from the
    /// instance metadata. For more information, see [Work with
    /// instance tags using the instance
    /// metadata](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html#work-with-tags-in-IMDS).
    ///
    /// Default: `disabled`
    instance_metadata_tags: ?InstanceMetadataTagsState,
};
