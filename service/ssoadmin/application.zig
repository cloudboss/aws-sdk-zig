const PortalOptions = @import("portal_options.zig").PortalOptions;
const ApplicationStatus = @import("application_status.zig").ApplicationStatus;

/// A structure that describes an application that uses IAM Identity Center for
/// access management.
pub const Application = struct {
    /// The Amazon Web Services account ID number of the application.
    application_account: ?[]const u8 = null,

    /// The ARN of the application.
    application_arn: ?[]const u8 = null,

    /// The ARN of the application provider for this application.
    application_provider_arn: ?[]const u8 = null,

    /// The date and time when the application was originally created.
    created_date: ?i64 = null,

    /// The Amazon Web Services Region where the application was created in IAM
    /// Identity Center.
    created_from: ?[]const u8 = null,

    /// The description of the application.
    description: ?[]const u8 = null,

    /// The ARN of the instance of IAM Identity Center that is configured with this
    /// application.
    instance_arn: ?[]const u8 = null,

    /// The name of the application.
    name: ?[]const u8 = null,

    /// A structure that describes the options for the access portal associated with
    /// this application.
    portal_options: ?PortalOptions = null,

    /// The current status of the application in this instance of IAM Identity
    /// Center.
    status: ?ApplicationStatus = null,

    pub const json_field_names = .{
        .application_account = "ApplicationAccount",
        .application_arn = "ApplicationArn",
        .application_provider_arn = "ApplicationProviderArn",
        .created_date = "CreatedDate",
        .created_from = "CreatedFrom",
        .description = "Description",
        .instance_arn = "InstanceArn",
        .name = "Name",
        .portal_options = "PortalOptions",
        .status = "Status",
    };
};
