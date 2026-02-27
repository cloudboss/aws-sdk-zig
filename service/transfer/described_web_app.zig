const DescribedWebAppEndpointDetails = @import("described_web_app_endpoint_details.zig").DescribedWebAppEndpointDetails;
const DescribedWebAppIdentityProviderDetails = @import("described_web_app_identity_provider_details.zig").DescribedWebAppIdentityProviderDetails;
const WebAppEndpointType = @import("web_app_endpoint_type.zig").WebAppEndpointType;
const Tag = @import("tag.zig").Tag;
const WebAppEndpointPolicy = @import("web_app_endpoint_policy.zig").WebAppEndpointPolicy;
const WebAppUnits = @import("web_app_units.zig").WebAppUnits;

/// A structure that describes the parameters for the web app, as identified by
/// the `WebAppId`.
pub const DescribedWebApp = struct {
    /// The `AccessEndpoint` is the URL that you provide to your users for them to
    /// interact with the Transfer Family web app. You can specify a custom URL or
    /// use the default value.
    access_endpoint: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the web app.
    arn: []const u8,

    /// The endpoint configuration details for the web app, including VPC settings
    /// if the endpoint is hosted within a VPC.
    described_endpoint_details: ?DescribedWebAppEndpointDetails,

    /// A structure that contains the details for the identity provider used by the
    /// web app.
    described_identity_provider_details: ?DescribedWebAppIdentityProviderDetails,

    /// The type of endpoint hosting the web app. Valid values are `PUBLIC` for
    /// publicly accessible endpoints and `VPC` for VPC-hosted endpoints that
    /// provide network isolation.
    endpoint_type: ?WebAppEndpointType,

    /// Key-value pairs that can be used to group and search for web apps. Tags are
    /// metadata attached to web apps for any purpose.
    tags: ?[]const Tag,

    /// The `WebAppEndpoint` is the unique URL for your Transfer Family web app.
    /// This is the value that you use when you configure **Origins** on CloudFront.
    web_app_endpoint: ?[]const u8,

    /// Setting for the type of endpoint policy for the web app. The default value
    /// is `STANDARD`.
    ///
    /// If your web app was created in an Amazon Web Services GovCloud (US) Region,
    /// the value of this parameter can be `FIPS`, which indicates the web app
    /// endpoint is FIPS-compliant.
    web_app_endpoint_policy: ?WebAppEndpointPolicy,

    /// The unique identifier for the web app.
    web_app_id: []const u8,

    /// A union that contains the value for number of concurrent connections or the
    /// user sessions on your web app.
    web_app_units: ?WebAppUnits,

    pub const json_field_names = .{
        .access_endpoint = "AccessEndpoint",
        .arn = "Arn",
        .described_endpoint_details = "DescribedEndpointDetails",
        .described_identity_provider_details = "DescribedIdentityProviderDetails",
        .endpoint_type = "EndpointType",
        .tags = "Tags",
        .web_app_endpoint = "WebAppEndpoint",
        .web_app_endpoint_policy = "WebAppEndpointPolicy",
        .web_app_id = "WebAppId",
        .web_app_units = "WebAppUnits",
    };
};
