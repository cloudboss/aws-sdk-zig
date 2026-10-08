const std = @import("std");

/// Type of managed skill that can be enabled or disabled for a pentest.
pub const SkillType = enum {
    /// The finding personalization skill learns customer preferences from finding
    /// edits and aligns future findings accordingly.
    finding_personalization,
    /// The login optimization skill learns application login flows to improve
    /// authentication success across runs.
    login_optimization,

    pub const json_field_names = .{
        .finding_personalization = "FINDING_PERSONALIZATION",
        .login_optimization = "LOGIN_OPTIMIZATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .finding_personalization => "FINDING_PERSONALIZATION",
            .login_optimization => "LOGIN_OPTIMIZATION",
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
