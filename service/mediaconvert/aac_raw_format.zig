const std = @import("std");

/// Enables LATM/LOAS AAC output. Note that if you use LATM/LOAS AAC in an
/// output, you must choose "No container" for the output container.
pub const AacRawFormat = enum {
    latm_loas,
    none,

    pub const json_field_names = .{
        .latm_loas = "LATM_LOAS",
        .none = "NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .latm_loas => "LATM_LOAS",
            .none => "NONE",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
