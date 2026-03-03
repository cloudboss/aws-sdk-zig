const std = @import("std");

pub const SpeakerStatus = enum {
    enrolled,
    expired,
    opted_out,
    pending,

    pub const json_field_names = .{
        .enrolled = "ENROLLED",
        .expired = "EXPIRED",
        .opted_out = "OPTED_OUT",
        .pending = "PENDING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enrolled => "ENROLLED",
            .expired => "EXPIRED",
            .opted_out => "OPTED_OUT",
            .pending => "PENDING",
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
