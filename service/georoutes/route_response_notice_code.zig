const std = @import("std");

pub const RouteResponseNoticeCode = enum {
    main_language_not_found,
    other,
    travel_time_exceeds_driver_work_hours,

    pub const json_field_names = .{
        .main_language_not_found = "MainLanguageNotFound",
        .other = "Other",
        .travel_time_exceeds_driver_work_hours = "TravelTimeExceedsDriverWorkHours",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .main_language_not_found => "MainLanguageNotFound",
            .other => "Other",
            .travel_time_exceeds_driver_work_hours => "TravelTimeExceedsDriverWorkHours",
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
