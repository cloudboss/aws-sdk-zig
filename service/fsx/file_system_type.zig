const std = @import("std");

/// The type of Amazon FSx file system.
pub const FileSystemType = enum {
    windows,
    lustre,
    ontap,
    openzfs,

    pub const json_field_names = .{
        .windows = "WINDOWS",
        .lustre = "LUSTRE",
        .ontap = "ONTAP",
        .openzfs = "OPENZFS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .windows => "WINDOWS",
            .lustre => "LUSTRE",
            .ontap => "ONTAP",
            .openzfs => "OPENZFS",
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
