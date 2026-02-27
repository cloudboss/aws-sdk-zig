const CommunicationType = @import("communication_type.zig").CommunicationType;

pub const IncidentResponder = struct {
    communication_preferences: ?[]const CommunicationType,

    email: []const u8,

    job_title: []const u8,

    name: []const u8,

    pub const json_field_names = .{
        .communication_preferences = "communicationPreferences",
        .email = "email",
        .job_title = "jobTitle",
        .name = "name",
    };
};
