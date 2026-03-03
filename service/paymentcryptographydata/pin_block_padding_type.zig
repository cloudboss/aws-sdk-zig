const std = @import("std");

pub const PinBlockPaddingType = enum {
    no_padding,
    iso_iec_7816_4,

    pub const json_field_names = .{
        .no_padding = "NO_PADDING",
        .iso_iec_7816_4 = "ISO_IEC_7816_4",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no_padding => "NO_PADDING",
            .iso_iec_7816_4 => "ISO_IEC_7816_4",
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
