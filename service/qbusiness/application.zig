const IdentityType = @import("identity_type.zig").IdentityType;
const QuickSightConfiguration = @import("quick_sight_configuration.zig").QuickSightConfiguration;
const ApplicationStatus = @import("application_status.zig").ApplicationStatus;

/// Summary information for an Amazon Q Business application.
pub const Application = struct {
    /// The identifier for the Amazon Q Business application.
    application_id: ?[]const u8 = null,

    /// The Unix timestamp when the Amazon Q Business application was created.
    created_at: ?i64 = null,

    /// The name of the Amazon Q Business application.
    display_name: ?[]const u8 = null,

    /// The authentication type being used by a Amazon Q Business application.
    identity_type: ?IdentityType = null,

    /// The Amazon Quick Suite configuration for an Amazon Q Business application
    /// that uses Quick Suite as the identity provider.
    quick_sight_configuration: ?QuickSightConfiguration = null,

    /// The status of the Amazon Q Business application. The application is ready to
    /// use when the status is `ACTIVE`.
    status: ?ApplicationStatus = null,

    /// The Unix timestamp when the Amazon Q Business application was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .created_at = "createdAt",
        .display_name = "displayName",
        .identity_type = "identityType",
        .quick_sight_configuration = "quickSightConfiguration",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
