const std = @import("std");

/// The currently selected maintenance day.
pub const MaintenanceDay = enum {
    monday,
    tuesday,
    wednesday,
    thursday,
    friday,
    saturday,
    sunday,

    pub const json_field_names = .{
        .monday = "MONDAY",
        .tuesday = "TUESDAY",
        .wednesday = "WEDNESDAY",
        .thursday = "THURSDAY",
        .friday = "FRIDAY",
        .saturday = "SATURDAY",
        .sunday = "SUNDAY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .monday => "MONDAY",
            .tuesday => "TUESDAY",
            .wednesday => "WEDNESDAY",
            .thursday => "THURSDAY",
            .friday => "FRIDAY",
            .saturday => "SATURDAY",
            .sunday => "SUNDAY",
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
