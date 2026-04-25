const InstanceMetadataEndpointState = @import("instance_metadata_endpoint_state.zig").InstanceMetadataEndpointState;
const InstanceMetadataProtocolState = @import("instance_metadata_protocol_state.zig").InstanceMetadataProtocolState;
const HttpTokensState = @import("http_tokens_state.zig").HttpTokensState;
const InstanceMetadataTagsState = @import("instance_metadata_tags_state.zig").InstanceMetadataTagsState;
const InstanceMetadataOptionsState = @import("instance_metadata_options_state.zig").InstanceMetadataOptionsState;

/// The metadata options for the instance.
pub const InstanceMetadataOptionsResponse = struct {
    /// Indicates whether the HTTP metadata endpoint on your instances is enabled or
    /// disabled.
    ///
    /// If the value is `disabled`, you cannot access your instance
    /// metadata.
    http_endpoint: ?InstanceMetadataEndpointState = null,

    /// Indicates whether the IPv6 endpoint for the instance metadata service is
    /// enabled or
    /// disabled.
    ///
    /// Default: `disabled`
    http_protocol_ipv_6: ?InstanceMetadataProtocolState = null,

    /// The maximum number of hops that the metadata token can travel.
    ///
    /// Possible values: Integers from `1` to `64`
    http_put_response_hop_limit: ?i32 = null,

    /// Indicates whether IMDSv2 is required.
    ///
    /// * `optional` - IMDSv2 is optional, which means that you can use
    /// either IMDSv2 or IMDSv1.
    ///
    /// * `required` - IMDSv2 is required, which means that IMDSv1 is
    /// disabled, and you must use IMDSv2.
    http_tokens: ?HttpTokensState = null,

    /// Indicates whether access to instance tags from the instance metadata is
    /// enabled or
    /// disabled. For more information, see [View tags for your EC2
    /// instances using instance
    /// metadata](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/work-with-tags-in-IMDS.html).
    instance_metadata_tags: ?InstanceMetadataTagsState = null,

    /// The state of the metadata option changes.
    ///
    /// `pending` - The metadata options are being updated and the instance is not
    /// ready to process metadata traffic with the new selection.
    ///
    /// `applied` - The metadata options have been successfully applied on the
    /// instance.
    state: ?InstanceMetadataOptionsState = null,
};
