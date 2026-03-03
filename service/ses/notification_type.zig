const std = @import("std");

pub const NotificationType = enum {
    bounce,
    complaint,
    delivery,

    pub const json_field_names = .{
        .bounce = "Bounce",
        .complaint = "Complaint",
        .delivery = "Delivery",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .bounce => "Bounce",
            .complaint => "Complaint",
            .delivery => "Delivery",
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
