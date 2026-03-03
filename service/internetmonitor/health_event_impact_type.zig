const std = @import("std");

pub const HealthEventImpactType = enum {
    availability,
    performance,
    local_availability,
    local_performance,

    pub const json_field_names = .{
        .availability = "AVAILABILITY",
        .performance = "PERFORMANCE",
        .local_availability = "LOCAL_AVAILABILITY",
        .local_performance = "LOCAL_PERFORMANCE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .availability => "AVAILABILITY",
            .performance => "PERFORMANCE",
            .local_availability => "LOCAL_AVAILABILITY",
            .local_performance => "LOCAL_PERFORMANCE",
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
