const std = @import("std");

pub const Specialty = enum {
    primarycare,
    cardiology,
    neurology,
    oncology,
    radiology,
    urology,

    pub const json_field_names = .{
        .primarycare = "PRIMARYCARE",
        .cardiology = "CARDIOLOGY",
        .neurology = "NEUROLOGY",
        .oncology = "ONCOLOGY",
        .radiology = "RADIOLOGY",
        .urology = "UROLOGY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .primarycare => "PRIMARYCARE",
            .cardiology => "CARDIOLOGY",
            .neurology => "NEUROLOGY",
            .oncology => "ONCOLOGY",
            .radiology => "RADIOLOGY",
            .urology => "UROLOGY",
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
