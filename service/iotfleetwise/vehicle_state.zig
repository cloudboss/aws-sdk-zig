const std = @import("std");

pub const VehicleState = enum {
    created,
    ready,
    healthy,
    suspended,
    deleting,
    ready_for_checkin,

    pub const json_field_names = .{
        .created = "CREATED",
        .ready = "READY",
        .healthy = "HEALTHY",
        .suspended = "SUSPENDED",
        .deleting = "DELETING",
        .ready_for_checkin = "READY_FOR_CHECKIN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .created => "CREATED",
            .ready => "READY",
            .healthy => "HEALTHY",
            .suspended => "SUSPENDED",
            .deleting => "DELETING",
            .ready_for_checkin => "READY_FOR_CHECKIN",
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
