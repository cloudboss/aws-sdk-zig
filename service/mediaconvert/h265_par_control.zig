const std = @import("std");

/// Optional. Specify how the service determines the pixel aspect ratio (PAR)
/// for this output. The default behavior, Follow source, uses the PAR from your
/// input video for your output. To specify a different PAR, choose any value
/// other than Follow source. When you choose SPECIFIED for this setting, you
/// must also specify values for the parNumerator and parDenominator settings.
pub const H265ParControl = enum {
    initialize_from_source,
    specified,

    pub const json_field_names = .{
        .initialize_from_source = "INITIALIZE_FROM_SOURCE",
        .specified = "SPECIFIED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .initialize_from_source => "INITIALIZE_FROM_SOURCE",
            .specified => "SPECIFIED",
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
