const aws = @import("aws");

const Authorization = @import("authorization.zig").Authorization;
const EndpointConfigurationResponse = @import("endpoint_configuration_response.zig").EndpointConfigurationResponse;
const PortalContent = @import("portal_content.zig").PortalContent;
const Preview = @import("preview.zig").Preview;
const PublishStatus = @import("publish_status.zig").PublishStatus;
const StatusException = @import("status_exception.zig").StatusException;

/// Represents a portal summary.
pub const PortalSummary = struct {
    /// The authorization of the portal.
    authorization: Authorization,

    /// The endpoint configuration of the portal.
    endpoint_configuration: EndpointConfigurationResponse,

    /// The ARNs of the portal products included in the portal.
    included_portal_product_arns: []const []const u8,

    /// The timestamp when the portal was last modified.
    last_modified: i64,

    /// The timestamp when the portal was last published.
    last_published: ?i64 = null,

    /// The description of the portal the last time it was published.
    last_published_description: ?[]const u8 = null,

    /// The ARN of the portal.
    portal_arn: []const u8,

    /// Contains the content that is visible to portal consumers including the
    /// themes, display names, and description.
    portal_content: PortalContent,

    /// The portal identifier.
    portal_id: []const u8,

    /// Represents the preview endpoint and the any possible error messages during
    /// preview generation.
    preview: ?Preview = null,

    /// The publish status.
    publish_status: ?PublishStatus = null,

    /// The CloudWatch RUM app monitor name.
    rum_app_monitor_name: ?[]const u8 = null,

    /// The status exception information.
    status_exception: ?StatusException = null,

    /// The collection of tags. Each tag element is associated with a given
    /// resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .authorization = "Authorization",
        .endpoint_configuration = "EndpointConfiguration",
        .included_portal_product_arns = "IncludedPortalProductArns",
        .last_modified = "LastModified",
        .last_published = "LastPublished",
        .last_published_description = "LastPublishedDescription",
        .portal_arn = "PortalArn",
        .portal_content = "PortalContent",
        .portal_id = "PortalId",
        .preview = "Preview",
        .publish_status = "PublishStatus",
        .rum_app_monitor_name = "RumAppMonitorName",
        .status_exception = "StatusException",
        .tags = "Tags",
    };
};
