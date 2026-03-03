const std = @import("std");

pub const CampaignStatus = enum {
    creating,
    waiting_for_approval,
    running,
    suspended,

    pub const json_field_names = .{
        .creating = "CREATING",
        .waiting_for_approval = "WAITING_FOR_APPROVAL",
        .running = "RUNNING",
        .suspended = "SUSPENDED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .waiting_for_approval => "WAITING_FOR_APPROVAL",
            .running => "RUNNING",
            .suspended => "SUSPENDED",
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
