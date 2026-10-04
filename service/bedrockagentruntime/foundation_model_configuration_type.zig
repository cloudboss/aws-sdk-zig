const std = @import("std");

/// The type of foundation model configuration.
pub const FoundationModelConfigurationType = enum {
    bedrock_foundation_model,
    mantle_foundation_model,

    pub const json_field_names = .{
        .bedrock_foundation_model = "BEDROCK_FOUNDATION_MODEL",
        .mantle_foundation_model = "MANTLE_FOUNDATION_MODEL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .bedrock_foundation_model => "BEDROCK_FOUNDATION_MODEL",
            .mantle_foundation_model => "MANTLE_FOUNDATION_MODEL",
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
