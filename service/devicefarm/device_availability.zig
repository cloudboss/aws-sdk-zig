const std = @import("std");

pub const DeviceAvailability = enum {
    temporary_not_available,
    busy,
    available,
    highly_available,

    pub const json_field_names = .{
        .temporary_not_available = "TEMPORARY_NOT_AVAILABLE",
        .busy = "BUSY",
        .available = "AVAILABLE",
        .highly_available = "HIGHLY_AVAILABLE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .temporary_not_available => "TEMPORARY_NOT_AVAILABLE",
            .busy => "BUSY",
            .available => "AVAILABLE",
            .highly_available => "HIGHLY_AVAILABLE",
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
