const MemberDefinition = @import("member_definition.zig").MemberDefinition;
const NotificationConfiguration = @import("notification_configuration.zig").NotificationConfiguration;
const WorkerAccessConfiguration = @import("worker_access_configuration.zig").WorkerAccessConfiguration;

/// Provides details about a labeling work team.
pub const Workteam = struct {
    /// The date and time that the work team was created (timestamp).
    create_date: ?i64,

    /// A description of the work team.
    description: []const u8,

    /// The date and time that the work team was last updated (timestamp).
    last_updated_date: ?i64,

    /// A list of `MemberDefinition` objects that contains objects that identify the
    /// workers that make up the work team.
    ///
    /// Workforces can be created using Amazon Cognito or your own OIDC Identity
    /// Provider (IdP). For private workforces created using Amazon Cognito use
    /// `CognitoMemberDefinition`. For workforces created using your own OIDC
    /// identity provider (IdP) use `OidcMemberDefinition`.
    member_definitions: []const MemberDefinition,

    /// Configures SNS notifications of available or expiring work items for work
    /// teams.
    notification_configuration: ?NotificationConfiguration,

    /// The Amazon Marketplace identifier for a vendor's work team.
    product_listing_ids: ?[]const []const u8,

    /// The URI of the labeling job's user interface. Workers open this URI to start
    /// labeling your data objects.
    sub_domain: ?[]const u8,

    /// Describes any access constraints that have been defined for Amazon S3
    /// resources.
    worker_access_configuration: ?WorkerAccessConfiguration,

    /// The Amazon Resource Name (ARN) of the workforce.
    workforce_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) that identifies the work team.
    workteam_arn: []const u8,

    /// The name of the work team.
    workteam_name: []const u8,

    pub const json_field_names = .{
        .create_date = "CreateDate",
        .description = "Description",
        .last_updated_date = "LastUpdatedDate",
        .member_definitions = "MemberDefinitions",
        .notification_configuration = "NotificationConfiguration",
        .product_listing_ids = "ProductListingIds",
        .sub_domain = "SubDomain",
        .worker_access_configuration = "WorkerAccessConfiguration",
        .workforce_arn = "WorkforceArn",
        .workteam_arn = "WorkteamArn",
        .workteam_name = "WorkteamName",
    };
};
