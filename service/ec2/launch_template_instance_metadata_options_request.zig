const LaunchTemplateInstanceMetadataEndpointState = @import("launch_template_instance_metadata_endpoint_state.zig").LaunchTemplateInstanceMetadataEndpointState;
const LaunchTemplateInstanceMetadataProtocolIpv6 = @import("launch_template_instance_metadata_protocol_ipv_6.zig").LaunchTemplateInstanceMetadataProtocolIpv6;
const LaunchTemplateHttpTokensState = @import("launch_template_http_tokens_state.zig").LaunchTemplateHttpTokensState;
const LaunchTemplateInstanceMetadataTagsState = @import("launch_template_instance_metadata_tags_state.zig").LaunchTemplateInstanceMetadataTagsState;

/// The metadata options for the instance. For more information, see [Use
/// instance metadata to manage your EC2
/// instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html) in the
/// *Amazon EC2 User Guide*.
pub const LaunchTemplateInstanceMetadataOptionsRequest = struct {
    /// Enables or disables the HTTP metadata endpoint on your instances. If the
    /// parameter is
    /// not specified, the default state is `enabled`.
    ///
    /// **Note:**
    ///
    /// If you specify a value of `disabled`, you will not be able to access
    /// your instance metadata.
    http_endpoint: ?LaunchTemplateInstanceMetadataEndpointState,

    /// Enables or disables the IPv6 endpoint for the instance metadata service.
    ///
    /// Default: `disabled`
    http_protocol_ipv_6: ?LaunchTemplateInstanceMetadataProtocolIpv6,

    /// The desired HTTP PUT response hop limit for instance metadata requests. The
    /// larger the
    /// number, the further instance metadata requests can travel.
    ///
    /// Default: `1`
    ///
    /// Possible values: Integers from 1 to 64
    http_put_response_hop_limit: ?i32,

    /// Indicates whether IMDSv2 is required.
    ///
    /// * `optional` - IMDSv2 is optional. You can choose whether to send a
    /// session token in your instance metadata retrieval requests. If you retrieve
    /// IAM
    /// role credentials without a session token, you receive the IMDSv1 role
    /// credentials. If you retrieve IAM role credentials using a valid session
    /// token,
    /// you receive the IMDSv2 role credentials.
    ///
    /// * `required` - IMDSv2 is required. You must send a session token in
    /// your instance metadata retrieval requests. With this option, retrieving the
    /// IAM
    /// role credentials always returns IMDSv2 credentials; IMDSv1 credentials are
    /// not
    /// available.
    ///
    /// Default: If the value of `ImdsSupport` for the Amazon Machine Image (AMI)
    /// for your instance is `v2.0`, the default is `required`.
    http_tokens: ?LaunchTemplateHttpTokensState,

    /// Set to `enabled` to allow access to instance tags from the instance
    /// metadata. Set to `disabled` to turn off access to instance tags from the
    /// instance metadata. For more information, see [View tags for your EC2
    /// instances using instance
    /// metadata](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/work-with-tags-in-IMDS.html).
    ///
    /// Default: `disabled`
    instance_metadata_tags: ?LaunchTemplateInstanceMetadataTagsState,
};
