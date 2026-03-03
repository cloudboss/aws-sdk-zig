const std = @import("std");

pub const ResourceTypeNotFound = enum {
    channel_group,
    channel,
    origin_endpoint,
    harvest_job,

    pub const json_field_names = .{
        .channel_group = "CHANNEL_GROUP",
        .channel = "CHANNEL",
        .origin_endpoint = "ORIGIN_ENDPOINT",
        .harvest_job = "HARVEST_JOB",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .channel_group => "CHANNEL_GROUP",
            .channel => "CHANNEL",
            .origin_endpoint => "ORIGIN_ENDPOINT",
            .harvest_job => "HARVEST_JOB",
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
