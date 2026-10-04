const std = @import("std");

/// DlClass for LoRaWAM, valid values are ClassB and ClassC.
pub const DlClass = enum {
    class_b,
    class_c,

    pub const json_field_names = .{
        .class_b = "ClassB",
        .class_c = "ClassC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .class_b => "ClassB",
            .class_c => "ClassC",
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
