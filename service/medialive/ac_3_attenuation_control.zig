const std = @import("std");

/// Ac3 Attenuation Control
pub const Ac3AttenuationControl = enum {
    attenuate_3_db,
    none,

    pub const json_field_names = .{
        .attenuate_3_db = "ATTENUATE_3_DB",
        .none = "NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .attenuate_3_db => "ATTENUATE_3_DB",
            .none => "NONE",
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
