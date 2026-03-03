const std = @import("std");

pub const FailoverStatus = enum {
    pending,
    failing_over,
    cancelling,

    pub const json_field_names = .{
        .pending = "pending",
        .failing_over = "failing-over",
        .cancelling = "cancelling",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "pending",
            .failing_over => "failing-over",
            .cancelling => "cancelling",
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
