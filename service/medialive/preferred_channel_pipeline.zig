const std = @import("std");

/// Indicates which pipeline is preferred by the multiplex for program ingest.
/// If set to \"PIPELINE_0\" or \"PIPELINE_1\" and an unhealthy ingest causes
/// the multiplex to switch to the non-preferred pipeline,
/// it will switch back once that ingest is healthy again. If set to
/// \"CURRENTLY_ACTIVE\",
/// it will not switch back to the other pipeline based on it recovering to a
/// healthy state,
/// it will only switch if the active pipeline becomes unhealthy.
pub const PreferredChannelPipeline = enum {
    currently_active,
    pipeline_0,
    pipeline_1,

    pub const json_field_names = .{
        .currently_active = "CURRENTLY_ACTIVE",
        .pipeline_0 = "PIPELINE_0",
        .pipeline_1 = "PIPELINE_1",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .currently_active => "CURRENTLY_ACTIVE",
            .pipeline_0 => "PIPELINE_0",
            .pipeline_1 => "PIPELINE_1",
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
