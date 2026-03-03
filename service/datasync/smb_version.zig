const std = @import("std");

pub const SmbVersion = enum {
    automatic,
    smb2,
    smb3,
    smb1,
    smb2_0,

    pub const json_field_names = .{
        .automatic = "AUTOMATIC",
        .smb2 = "SMB2",
        .smb3 = "SMB3",
        .smb1 = "SMB1",
        .smb2_0 = "SMB2_0",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .automatic => "AUTOMATIC",
            .smb2 => "SMB2",
            .smb3 => "SMB3",
            .smb1 => "SMB1",
            .smb2_0 => "SMB2_0",
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
