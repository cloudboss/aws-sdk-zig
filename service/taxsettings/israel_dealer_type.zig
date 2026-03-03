const std = @import("std");

pub const IsraelDealerType = enum {
    authorized,
    non_authorized,

    pub const json_field_names = .{
        .authorized = "Authorized",
        .non_authorized = "Non-authorized",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .authorized => "Authorized",
            .non_authorized => "Non-authorized",
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
