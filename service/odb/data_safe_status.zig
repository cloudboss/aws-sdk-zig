const std = @import("std");

pub const DataSafeStatus = enum {
    registering,
    registered,
    deregistering,
    not_registered,
    failed,

    pub const json_field_names = .{
        .registering = "REGISTERING",
        .registered = "REGISTERED",
        .deregistering = "DEREGISTERING",
        .not_registered = "NOT_REGISTERED",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .registering => "REGISTERING",
            .registered => "REGISTERED",
            .deregistering => "DEREGISTERING",
            .not_registered => "NOT_REGISTERED",
            .failed => "FAILED",
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
