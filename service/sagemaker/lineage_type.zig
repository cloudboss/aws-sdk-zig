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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
