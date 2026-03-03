const std = @import("std");

pub const IsolineEngineType = enum {
    electric,
    internal_combustion,
    plugin_hybrid,

    pub const json_field_names = .{
        .electric = "Electric",
        .internal_combustion = "InternalCombustion",
        .plugin_hybrid = "PluginHybrid",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .electric => "Electric",
            .internal_combustion => "InternalCombustion",
            .plugin_hybrid => "PluginHybrid",
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
