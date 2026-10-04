const std = @import("std");

pub const RecommendationType = enum {
    infra_only,
    workload_only,
    all,

    pub const json_field_names = .{
        .infra_only = "INFRA_ONLY",
        .workload_only = "WORKLOAD_ONLY",
        .all = "ALL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .infra_only => "INFRA_ONLY",
            .workload_only => "WORKLOAD_ONLY",
            .all => "ALL",
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
