const std = @import("std");

pub const SNOMEDCTEntityType = enum {
    dx_name,
    test_name,
    procedure_name,
    treatment_name,

    pub const json_field_names = .{
        .dx_name = "DX_NAME",
        .test_name = "TEST_NAME",
        .procedure_name = "PROCEDURE_NAME",
        .treatment_name = "TREATMENT_NAME",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .dx_name => "DX_NAME",
            .test_name => "TEST_NAME",
            .procedure_name => "PROCEDURE_NAME",
            .treatment_name => "TREATMENT_NAME",
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
