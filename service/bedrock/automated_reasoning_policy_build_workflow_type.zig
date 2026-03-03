const std = @import("std");

pub const AutomatedReasoningPolicyBuildWorkflowType = enum {
    ingest_content,
    refine_policy,
    import_policy,

    pub const json_field_names = .{
        .ingest_content = "INGEST_CONTENT",
        .refine_policy = "REFINE_POLICY",
        .import_policy = "IMPORT_POLICY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ingest_content => "INGEST_CONTENT",
            .refine_policy => "REFINE_POLICY",
            .import_policy => "IMPORT_POLICY",
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
