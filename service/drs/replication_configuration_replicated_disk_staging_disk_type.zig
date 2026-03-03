const std = @import("std");

pub const ReplicationConfigurationReplicatedDiskStagingDiskType = enum {
    auto,
    gp2,
    gp3,
    io1,
    sc1,
    st1,
    standard,

    pub const json_field_names = .{
        .auto = "AUTO",
        .gp2 = "GP2",
        .gp3 = "GP3",
        .io1 = "IO1",
        .sc1 = "SC1",
        .st1 = "ST1",
        .standard = "STANDARD",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .auto => "AUTO",
            .gp2 => "GP2",
            .gp3 => "GP3",
            .io1 => "IO1",
            .sc1 => "SC1",
            .st1 => "ST1",
            .standard => "STANDARD",
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
