const std = @import("std");

pub const CacheMode = enum {
    local_docker_layer_cache,
    local_source_cache,
    local_custom_cache,

    pub const json_field_names = .{
        .local_docker_layer_cache = "LOCAL_DOCKER_LAYER_CACHE",
        .local_source_cache = "LOCAL_SOURCE_CACHE",
        .local_custom_cache = "LOCAL_CUSTOM_CACHE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .local_docker_layer_cache => "LOCAL_DOCKER_LAYER_CACHE",
            .local_source_cache => "LOCAL_SOURCE_CACHE",
            .local_custom_cache => "LOCAL_CUSTOM_CACHE",
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
