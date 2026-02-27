const OperationType = @import("operation_type.zig").OperationType;
const ProjectInformation = @import("project_information.zig").ProjectInformation;
const EventPayload = @import("event_payload.zig").EventPayload;
const UserIdentity = @import("user_identity.zig").UserIdentity;

/// Information about an entry in an event log of Amazon CodeCatalyst activity.
pub const EventLogEntry = struct {
    /// The code of the error, if any.
    error_code: ?[]const u8,

    /// The category for the event.
    event_category: []const u8,

    /// The name of the event.
    event_name: []const u8,

    /// The source of the event.
    event_source: []const u8,

    /// The time the event took place, in coordinated universal time (UTC) timestamp
    /// format as specified in [RFC
    /// 3339](https://www.rfc-editor.org/rfc/rfc3339#section-5.6).
    event_time: i64,

    /// The type of the event.
    event_type: []const u8,

    /// The system-generated unique ID of the event.
    id: []const u8,

    /// The type of the event.
    operation_type: OperationType,

    /// Information about the project where the event occurred.
    project_information: ?ProjectInformation,

    /// The system-generated unique ID of the request.
    request_id: ?[]const u8,

    /// Information about the payload of the request.
    request_payload: ?EventPayload,

    /// Information about the payload of the response, if any.
    response_payload: ?EventPayload,

    /// The IP address of the user whose actions are recorded in the event.
    source_ip_address: ?[]const u8,

    /// The user agent whose actions are recorded in the event.
    user_agent: ?[]const u8,

    /// The system-generated unique ID of the user whose actions are recorded in the
    /// event.
    user_identity: UserIdentity,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .event_category = "eventCategory",
        .event_name = "eventName",
        .event_source = "eventSource",
        .event_time = "eventTime",
        .event_type = "eventType",
        .id = "id",
        .operation_type = "operationType",
        .project_information = "projectInformation",
        .request_id = "requestId",
        .request_payload = "requestPayload",
        .response_payload = "responsePayload",
        .source_ip_address = "sourceIpAddress",
        .user_agent = "userAgent",
        .user_identity = "userIdentity",
    };
};
