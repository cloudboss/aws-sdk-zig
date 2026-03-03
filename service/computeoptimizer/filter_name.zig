const std = @import("std");

pub const FilterName = enum {
    finding,
    finding_reason_codes,
    recommendation_source_type,
    inferred_workload_types,

    pub const json_field_names = .{
        .finding = "Finding",
        .finding_reason_codes = "FindingReasonCodes",
        .recommendation_source_type = "RecommendationSourceType",
        .inferred_workload_types = "InferredWorkloadTypes",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .finding => "Finding",
            .finding_reason_codes => "FindingReasonCodes",
            .recommendation_source_type => "RecommendationSourceType",
            .inferred_workload_types => "InferredWorkloadTypes",
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
