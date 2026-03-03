const std = @import("std");

pub const SNOMEDCTEntityCategory = enum {
    medical_condition,
    anatomy,
    test_treatment_procedure,

    pub const json_field_names = .{
        .medical_condition = "MEDICAL_CONDITION",
        .anatomy = "ANATOMY",
        .test_treatment_procedure = "TEST_TREATMENT_PROCEDURE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .medical_condition => "MEDICAL_CONDITION",
            .anatomy => "ANATOMY",
            .test_treatment_procedure => "TEST_TREATMENT_PROCEDURE",
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
