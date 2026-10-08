const std = @import("std");

pub const FailureCategory = enum {
    shared_fate,
    excessive_load,
    excessive_latency,
    misconfiguration_and_bugs,
    single_point_of_failure,

    pub const json_field_names = .{
        .shared_fate = "SHARED_FATE",
        .excessive_load = "EXCESSIVE_LOAD",
        .excessive_latency = "EXCESSIVE_LATENCY",
        .misconfiguration_and_bugs = "MISCONFIGURATION_AND_BUGS",
        .single_point_of_failure = "SINGLE_POINT_OF_FAILURE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .shared_fate => "SHARED_FATE",
            .excessive_load => "EXCESSIVE_LOAD",
            .excessive_latency => "EXCESSIVE_LATENCY",
            .misconfiguration_and_bugs => "MISCONFIGURATION_AND_BUGS",
            .single_point_of_failure => "SINGLE_POINT_OF_FAILURE",
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
