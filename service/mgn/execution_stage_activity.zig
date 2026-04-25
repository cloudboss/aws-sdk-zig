const std = @import("std");

pub const ExecutionStageActivity = enum {
    mapping,
    mapping_update,
    code_generation,
    deploy,
    deployed_stacks_deletion,
    analyze,

    pub const json_field_names = .{
        .mapping = "MAPPING",
        .mapping_update = "MAPPING_UPDATE",
        .code_generation = "CODE_GENERATION",
        .deploy = "DEPLOY",
        .deployed_stacks_deletion = "DEPLOYED_STACKS_DELETION",
        .analyze = "ANALYZE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .mapping => "MAPPING",
            .mapping_update => "MAPPING_UPDATE",
            .code_generation => "CODE_GENERATION",
            .deploy => "DEPLOY",
            .deployed_stacks_deletion => "DEPLOYED_STACKS_DELETION",
            .analyze => "ANALYZE",
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
