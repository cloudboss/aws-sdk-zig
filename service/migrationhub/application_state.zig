const ApplicationStatus = @import("application_status.zig").ApplicationStatus;

/// The state of an application discovered through Migration Hub import, the AWS
/// Agentless
/// Discovery Connector, or the AWS Application Discovery Agent.
pub const ApplicationState = struct {
    /// The configurationId from the Application Discovery Service that uniquely
    /// identifies an
    /// application.
    application_id: ?[]const u8 = null,

    /// The current status of an application.
    application_status: ?ApplicationStatus = null,

    /// The timestamp when the application status was last updated.
    last_updated_time: ?i64 = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .application_status = "ApplicationStatus",
        .last_updated_time = "LastUpdatedTime",
    };
};
