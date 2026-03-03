const std = @import("std");

pub const EngagementType = enum {
    security_incident,
    investigation,

    pub const json_field_names = .{
        .security_incident = "Security Incident",
        .investigation = "Investigation",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .security_incident => "Security Incident",
            .investigation => "Investigation",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
