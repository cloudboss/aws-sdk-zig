const std = @import("std");

pub const ResourceType = enum {
    data_set,
    revision,
    asset,
    job,
    event_action,
    data_grant,

    pub const json_field_names = .{
        .data_set = "DATA_SET",
        .revision = "REVISION",
        .asset = "ASSET",
        .job = "JOB",
        .event_action = "EVENT_ACTION",
        .data_grant = "DATA_GRANT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .data_set => "DATA_SET",
            .revision => "REVISION",
            .asset => "ASSET",
            .job => "JOB",
            .event_action => "EVENT_ACTION",
            .data_grant => "DATA_GRANT",
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
