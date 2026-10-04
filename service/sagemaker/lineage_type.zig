const std = @import("std");

pub const LineageType = enum {
    trial_component,
    artifact,
    context,
    action,

    pub const json_field_names = .{
        .trial_component = "TrialComponent",
        .artifact = "Artifact",
        .context = "Context",
        .action = "Action",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .trial_component => "TrialComponent",
            .artifact => "Artifact",
            .context => "Context",
            .action => "Action",
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
