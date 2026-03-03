const PortalType = @import("portal_type.zig").PortalType;
const PortalStatus = @import("portal_status.zig").PortalStatus;

/// Contains a portal summary.
pub const PortalSummary = struct {
    /// The date the portal was created, in Unix epoch time.
    creation_date: ?i64 = null,

    /// The portal's description.
    description: ?[]const u8 = null,

    /// The ID of the portal.
    id: []const u8,

    /// The date the portal was last updated, in Unix epoch time.
    last_update_date: ?i64 = null,

    /// The name of the portal.
    name: []const u8,

    /// Define the type of portal. The value for IoT SiteWise Monitor (Classic) is
    /// `SITEWISE_PORTAL_V1`. The value for IoT SiteWise Monitor (AI-aware) is
    /// `SITEWISE_PORTAL_V2`.
    portal_type: ?PortalType = null,

    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the service role that allows the portal's users to access your IoT SiteWise
    /// resources on your behalf. For more information, see [Using service roles for
    /// IoT SiteWise
    /// Monitor](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/monitor-service-role.html) in the
    /// *IoT SiteWise User Guide*.
    role_arn: ?[]const u8 = null,

    /// The URL for the IoT SiteWise Monitor portal. You can use this URL to access
    /// portals that
    /// use IAM Identity Center for authentication. For portals that use IAM for
    /// authentication, you must use the
    /// IoT SiteWise console to get a URL that you can use to access the portal.
    start_url: []const u8,

    status: PortalStatus,

    pub const json_field_names = .{
        .creation_date = "creationDate",
        .description = "description",
        .id = "id",
        .last_update_date = "lastUpdateDate",
        .name = "name",
        .portal_type = "portalType",
        .role_arn = "roleArn",
        .start_url = "startUrl",
        .status = "status",
    };
};
