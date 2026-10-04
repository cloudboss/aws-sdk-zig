const std = @import("std");

pub const RouteTransitIncidentType = enum {
    accident,
    construction,
    demonstration,
    holiday,
    maintenance,
    medical_emergency,
    other,
    police_activity,
    strike,
    technical_problem,
    weather,

    pub const json_field_names = .{
        .accident = "Accident",
        .construction = "Construction",
        .demonstration = "Demonstration",
        .holiday = "Holiday",
        .maintenance = "Maintenance",
        .medical_emergency = "MedicalEmergency",
        .other = "Other",
        .police_activity = "PoliceActivity",
        .strike = "Strike",
        .technical_problem = "TechnicalProblem",
        .weather = "Weather",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .accident => "Accident",
            .construction => "Construction",
            .demonstration => "Demonstration",
            .holiday => "Holiday",
            .maintenance => "Maintenance",
            .medical_emergency => "MedicalEmergency",
            .other => "Other",
            .police_activity => "PoliceActivity",
            .strike => "Strike",
            .technical_problem => "TechnicalProblem",
            .weather => "Weather",
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
