const AccessType = @import("access_type.zig").AccessType;
const SessionManagerOutputUrl = @import("session_manager_output_url.zig").SessionManagerOutputUrl;
const SessionStatus = @import("session_status.zig").SessionStatus;

/// Information about a Session Manager connection to a managed node.
pub const Session = struct {
    /// `Standard` access type is the default for Session Manager sessions.
    /// `JustInTime` is the access type for [Just-in-time node
    /// access](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-just-in-time-node-access.html).
    access_type: ?AccessType = null,

    /// Reserved for future use.
    details: ?[]const u8 = null,

    /// The name of the Session Manager SSM document used to define the parameters
    /// and plugin settings for the
    /// session. For example, `SSM-SessionManagerRunShell`.
    document_name: ?[]const u8 = null,

    /// The date and time, in ISO-8601 Extended format, when the session was
    /// terminated.
    end_date: ?i64 = null,

    /// The maximum duration of a session before it terminates.
    max_session_duration: ?[]const u8 = null,

    /// Reserved for future use.
    output_url: ?SessionManagerOutputUrl = null,

    /// The ID of the Amazon Web Services user that started the session.
    owner: ?[]const u8 = null,

    /// The reason for connecting to the instance.
    reason: ?[]const u8 = null,

    /// The ID of the session.
    session_id: ?[]const u8 = null,

    /// The date and time, in ISO-8601 Extended format, when the session began.
    start_date: ?i64 = null,

    /// The status of the session. For example, "Connected" or "Terminated".
    status: ?SessionStatus = null,

    /// The managed node that the Session Manager session connected to.
    target: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_type = "AccessType",
        .details = "Details",
        .document_name = "DocumentName",
        .end_date = "EndDate",
        .max_session_duration = "MaxSessionDuration",
        .output_url = "OutputUrl",
        .owner = "Owner",
        .reason = "Reason",
        .session_id = "SessionId",
        .start_date = "StartDate",
        .status = "Status",
        .target = "Target",
    };
};
