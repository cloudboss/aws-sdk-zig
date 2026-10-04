const std = @import("std");

pub const FieldName = enum {
    crawl_id,
    state,
    start_time,
    end_time,
    dpu_hour,

    pub const json_field_names = .{
        .crawl_id = "CRAWL_ID",
        .state = "STATE",
        .start_time = "START_TIME",
        .end_time = "END_TIME",
        .dpu_hour = "DPU_HOUR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .crawl_id => "CRAWL_ID",
            .state => "STATE",
            .start_time => "START_TIME",
            .end_time => "END_TIME",
            .dpu_hour => "DPU_HOUR",
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
