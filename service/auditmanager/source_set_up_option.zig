const std = @import("std");

pub const SourceSetUpOption = enum {
    system_controls_mapping,
    procedural_controls_mapping,

    pub const json_field_names = .{
        .system_controls_mapping = "System_Controls_Mapping",
        .procedural_controls_mapping = "Procedural_Controls_Mapping",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .system_controls_mapping => "System_Controls_Mapping",
            .procedural_controls_mapping => "Procedural_Controls_Mapping",
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
