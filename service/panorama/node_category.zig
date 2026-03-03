const std = @import("std");

pub const NodeCategory = enum {
    business_logic,
    ml_model,
    media_source,
    media_sink,

    pub const json_field_names = .{
        .business_logic = "BUSINESS_LOGIC",
        .ml_model = "ML_MODEL",
        .media_source = "MEDIA_SOURCE",
        .media_sink = "MEDIA_SINK",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .business_logic => "BUSINESS_LOGIC",
            .ml_model => "ML_MODEL",
            .media_source => "MEDIA_SOURCE",
            .media_sink => "MEDIA_SINK",
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
