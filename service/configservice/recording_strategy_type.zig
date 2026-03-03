const std = @import("std");

pub const RecordingStrategyType = enum {
    all_supported_resource_types,
    inclusion_by_resource_types,
    exclusion_by_resource_types,

    pub const json_field_names = .{
        .all_supported_resource_types = "ALL_SUPPORTED_RESOURCE_TYPES",
        .inclusion_by_resource_types = "INCLUSION_BY_RESOURCE_TYPES",
        .exclusion_by_resource_types = "EXCLUSION_BY_RESOURCE_TYPES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .all_supported_resource_types => "ALL_SUPPORTED_RESOURCE_TYPES",
            .inclusion_by_resource_types => "INCLUSION_BY_RESOURCE_TYPES",
            .exclusion_by_resource_types => "EXCLUSION_BY_RESOURCE_TYPES",
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
