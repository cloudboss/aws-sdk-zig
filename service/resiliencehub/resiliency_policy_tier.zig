const std = @import("std");

pub const ResiliencyPolicyTier = enum {
    mission_critical,
    critical,
    important,
    core_services,
    non_critical,
    not_applicable,

    pub const json_field_names = .{
        .mission_critical = "MissionCritical",
        .critical = "Critical",
        .important = "Important",
        .core_services = "CoreServices",
        .non_critical = "NonCritical",
        .not_applicable = "NotApplicable",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .mission_critical => "MissionCritical",
            .critical => "Critical",
            .important => "Important",
            .core_services => "CoreServices",
            .non_critical => "NonCritical",
            .not_applicable => "NotApplicable",
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
