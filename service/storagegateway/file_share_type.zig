const std = @import("std");

/// The type of the file share.
pub const FileShareType = enum {
    nfs,
    smb,

    pub const json_field_names = .{
        .nfs = "NFS",
        .smb = "SMB",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .nfs => "NFS",
            .smb => "SMB",
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
