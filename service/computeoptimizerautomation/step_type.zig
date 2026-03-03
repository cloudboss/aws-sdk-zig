const std = @import("std");

pub const StepType = enum {
    create_ebs_snapshot,
    delete_ebs_volume,
    modify_ebs_volume,
    create_ebs_volume,

    pub const json_field_names = .{
        .create_ebs_snapshot = "CreateEbsSnapshot",
        .delete_ebs_volume = "DeleteEbsVolume",
        .modify_ebs_volume = "ModifyEbsVolume",
        .create_ebs_volume = "CreateEbsVolume",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .create_ebs_snapshot => "CreateEbsSnapshot",
            .delete_ebs_volume => "DeleteEbsVolume",
            .modify_ebs_volume => "ModifyEbsVolume",
            .create_ebs_volume => "CreateEbsVolume",
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
