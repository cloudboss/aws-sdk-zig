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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
