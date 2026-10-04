const std = @import("std");

pub const ParsingStrategy = enum {
    bedrock_foundation_model,
    bedrock_data_automation,
    smart_parsing,
    multi_modal_embeddings,

    pub const json_field_names = .{
        .bedrock_foundation_model = "BEDROCK_FOUNDATION_MODEL",
        .bedrock_data_automation = "BEDROCK_DATA_AUTOMATION",
        .smart_parsing = "SMART_PARSING",
        .multi_modal_embeddings = "MULTI_MODAL_EMBEDDINGS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .bedrock_foundation_model => "BEDROCK_FOUNDATION_MODEL",
            .bedrock_data_automation => "BEDROCK_DATA_AUTOMATION",
            .smart_parsing => "SMART_PARSING",
            .multi_modal_embeddings => "MULTI_MODAL_EMBEDDINGS",
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
