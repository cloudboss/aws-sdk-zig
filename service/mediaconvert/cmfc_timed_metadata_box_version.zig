const std = @import("std");

/// Specify the event message box (eMSG) version for ID3 timed metadata in your
/// output.
/// For more information, see ISO/IEC 23009-1:2022 section 5.10.3.3.3 Syntax.
/// Leave blank to use the default value Version 0.
/// When you specify Version 1, you must also set ID3 metadata to Passthrough.
pub const CmfcTimedMetadataBoxVersion = enum {
    version_0,
    version_1,

    pub const json_field_names = .{
        .version_0 = "VERSION_0",
        .version_1 = "VERSION_1",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .version_0 => "VERSION_0",
            .version_1 => "VERSION_1",
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
