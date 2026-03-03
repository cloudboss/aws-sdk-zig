const std = @import("std");

pub const AcceptanceType = enum {
    /// Do not require explicit click-through acceptance
    /// of the Term associated with this Report
    passthrough,
    /// Require explicit click-through acceptance of the
    /// Term associated with this Report.
    explicit,

    pub const json_field_names = .{
        .passthrough = "PASSTHROUGH",
        .explicit = "EXPLICIT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .passthrough => "PASSTHROUGH",
            .explicit => "EXPLICIT",
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
