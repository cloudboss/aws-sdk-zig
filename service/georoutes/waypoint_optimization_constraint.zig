const std = @import("std");

pub const WaypointOptimizationConstraint = enum {
    access_hours,
    appointment_time,
    before,
    heading,
    service_duration,
    side_of_street,

    pub const json_field_names = .{
        .access_hours = "AccessHours",
        .appointment_time = "AppointmentTime",
        .before = "Before",
        .heading = "Heading",
        .service_duration = "ServiceDuration",
        .side_of_street = "SideOfStreet",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .access_hours => "AccessHours",
            .appointment_time => "AppointmentTime",
            .before => "Before",
            .heading => "Heading",
            .service_duration => "ServiceDuration",
            .side_of_street => "SideOfStreet",
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
