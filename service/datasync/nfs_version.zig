const std = @import("std");

pub const NfsVersion = enum {
    automatic,
    nfs3,
    nfs4_0,
    nfs4_1,

    pub const json_field_names = .{
        .automatic = "AUTOMATIC",
        .nfs3 = "NFS3",
        .nfs4_0 = "NFS4_0",
        .nfs4_1 = "NFS4_1",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .automatic => "AUTOMATIC",
            .nfs3 => "NFS3",
            .nfs4_0 => "NFS4_0",
            .nfs4_1 => "NFS4_1",
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
