const std = @import("std");

pub const Protocol = enum {
    sftp,
    ftp,
    ftps,
    as2,

    pub const json_field_names = .{
        .sftp = "SFTP",
        .ftp = "FTP",
        .ftps = "FTPS",
        .as2 = "AS2",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sftp => "SFTP",
            .ftp => "FTP",
            .ftps => "FTPS",
            .as2 => "AS2",
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
