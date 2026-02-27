const AttendeeCapabilities = @import("attendee_capabilities.zig").AttendeeCapabilities;

/// The Amazon Chime SDK attendee fields to create, used with the
/// BatchCreateAttendee action.
pub const CreateAttendeeRequestItem = struct {
    /// A list of one or more capabilities.
    capabilities: ?AttendeeCapabilities,

    /// The Amazon Chime SDK external user ID. An idempotency token. Links the
    /// attendee to an identity managed by a builder application.
    ///
    /// Pattern: `[-_&@+=,(){}\[\]\/«».:|'"#a-zA-Z0-9À-ÿ\s]*`
    ///
    /// Values that begin with `aws:` are reserved. You can't configure a value that
    /// uses this prefix.
    /// Case insensitive.
    external_user_id: []const u8,

    pub const json_field_names = .{
        .capabilities = "Capabilities",
        .external_user_id = "ExternalUserId",
    };
};
