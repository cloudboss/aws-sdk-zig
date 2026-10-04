const std = @import("std");

/// A Contextual Metadata Enrichment method. Each value selects a strategy for
/// enriching the channel's output with contextual metadata derived from the
/// Elemental Inference feed. SCTE35_ELEMENTAL_INFERENCE_QUERY_PARAMS enriches
/// outbound SCTE-35 messages with query parameters that downstream systems can
/// use to call the Elemental Inference GetMetadata API.
pub const EnrichmentMethod = enum {
    scte35_elemental_inference_query_params,

    pub const json_field_names = .{
        .scte35_elemental_inference_query_params = "SCTE35_ELEMENTAL_INFERENCE_QUERY_PARAMS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .scte35_elemental_inference_query_params => "SCTE35_ELEMENTAL_INFERENCE_QUERY_PARAMS",
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
