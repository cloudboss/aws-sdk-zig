const std = @import("std");

pub const ReplicationConfigurationDefaultLargeStagingDiskType = enum {
    gp2,
    gp3,
    st1,
    auto,

    pub const json_field_names = .{
        .gp2 = "GP2",
        .gp3 = "GP3",
        .st1 = "ST1",
        .auto = "AUTO",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .gp2 => "GP2",
            .gp3 => "GP3",
            .st1 => "ST1",
            .auto => "AUTO",
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
