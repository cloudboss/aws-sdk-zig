const std = @import("std");

/// Input Filter
pub const InputFilter = enum {
    auto,
    disabled,
    forced,

    pub const json_field_names = .{
        .auto = "AUTO",
        .disabled = "DISABLED",
        .forced = "FORCED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .auto => "AUTO",
            .disabled => "DISABLED",
            .forced => "FORCED",
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
