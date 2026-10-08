const std = @import("std");

pub const AssessmentErrorCode = enum {
    invalid_permissions,
    cmk_access_denied,
    agent_error,
    internal_error,
    design_file_access_denied,

    pub const json_field_names = .{
        .invalid_permissions = "INVALID_PERMISSIONS",
        .cmk_access_denied = "CMK_ACCESS_DENIED",
        .agent_error = "AGENT_ERROR",
        .internal_error = "INTERNAL_ERROR",
        .design_file_access_denied = "DESIGN_FILE_ACCESS_DENIED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invalid_permissions => "INVALID_PERMISSIONS",
            .cmk_access_denied => "CMK_ACCESS_DENIED",
            .agent_error => "AGENT_ERROR",
            .internal_error => "INTERNAL_ERROR",
            .design_file_access_denied => "DESIGN_FILE_ACCESS_DENIED",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
