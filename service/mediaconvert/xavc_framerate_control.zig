const std = @import("std");

/// If you are using the console, use the Frame rate setting to specify the
/// frame rate for this output. If you want to keep the same frame rate as the
/// input video, choose Follow source. If you want to do frame rate conversion,
/// choose a frame rate from the dropdown list. The framerates shown in the
/// dropdown list are decimal approximations of fractions.
pub const XavcFramerateControl = enum {
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
