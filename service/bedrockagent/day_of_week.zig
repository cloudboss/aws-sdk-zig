const std = @import("std");

/// The day of the week on which a weekly sync runs. Valid values are the
/// standard English day names, for example, MONDAY or TUESDAY.
pub const DayOfWeek = enum {
    sunday,
    monday,
    tuesday,
    wednesday,
    thursday,
    friday,
    saturday,

    pub const json_field_names = .{
        .sunday = "SUNDAY",
        .monday = "MONDAY",
        .tuesday = "TUESDAY",
        .wednesday = "WEDNESDAY",
        .thursday = "THURSDAY",
        .friday = "FRIDAY",
        .saturday = "SATURDAY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sunday => "SUNDAY",
            .monday => "MONDAY",
            .tuesday => "TUESDAY",
            .wednesday => "WEDNESDAY",
            .thursday => "THURSDAY",
            .friday => "FRIDAY",
            .saturday => "SATURDAY",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
