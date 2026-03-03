const std = @import("std");

pub const SoftwareSetUpdateSchedule = enum {
    use_maintenance_window,
    apply_immediately,

    pub const json_field_names = .{
        .use_maintenance_window = "USE_MAINTENANCE_WINDOW",
        .apply_immediately = "APPLY_IMMEDIATELY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .use_maintenance_window => "USE_MAINTENANCE_WINDOW",
            .apply_immediately => "APPLY_IMMEDIATELY",
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
