const std = @import("std");

pub const EntityType = enum {
    medication,
    medical_condition,
    protected_health_information,
    test_treatment_procedure,
    anatomy,
    time_expression,
    behavioral_environmental_social,

    pub const json_field_names = .{
        .medication = "MEDICATION",
        .medical_condition = "MEDICAL_CONDITION",
        .protected_health_information = "PROTECTED_HEALTH_INFORMATION",
        .test_treatment_procedure = "TEST_TREATMENT_PROCEDURE",
        .anatomy = "ANATOMY",
        .time_expression = "TIME_EXPRESSION",
        .behavioral_environmental_social = "BEHAVIORAL_ENVIRONMENTAL_SOCIAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .medication => "MEDICATION",
            .medical_condition => "MEDICAL_CONDITION",
            .protected_health_information => "PROTECTED_HEALTH_INFORMATION",
            .test_treatment_procedure => "TEST_TREATMENT_PROCEDURE",
            .anatomy => "ANATOMY",
            .time_expression => "TIME_EXPRESSION",
            .behavioral_environmental_social => "BEHAVIORAL_ENVIRONMENTAL_SOCIAL",
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
