const std = @import("std");

pub const RunTimeAnalyzerName = enum {
    a2_c_analyzer,
    rehost_analyzer,
    emp_pa_analyzer,
    database_analyzer,
    sct_analyzer,

    pub const json_field_names = .{
        .a2_c_analyzer = "A2C_ANALYZER",
        .rehost_analyzer = "REHOST_ANALYZER",
        .emp_pa_analyzer = "EMP_PA_ANALYZER",
        .database_analyzer = "DATABASE_ANALYZER",
        .sct_analyzer = "SCT_ANALYZER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .a2_c_analyzer => "A2C_ANALYZER",
            .rehost_analyzer => "REHOST_ANALYZER",
            .emp_pa_analyzer => "EMP_PA_ANALYZER",
            .database_analyzer => "DATABASE_ANALYZER",
            .sct_analyzer => "SCT_ANALYZER",
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
