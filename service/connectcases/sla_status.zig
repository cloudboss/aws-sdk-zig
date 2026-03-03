const std = @import("std");

pub const SlaStatus = enum {
    active,
    overdue,
    met,
    not_met,

    pub const json_field_names = .{
        .active = "Active",
        .overdue = "Overdue",
        .met = "Met",
        .not_met = "NotMet",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "Active",
            .overdue => "Overdue",
            .met => "Met",
            .not_met => "NotMet",
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
