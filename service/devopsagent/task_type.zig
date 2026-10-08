const std = @import("std");

/// Types of tasks that can be created in the backlog
pub const TaskType = enum {
    /// Task for investigating issues or requirements
    investigation,
    /// Task for evaluating options or solutions (not in use)
    evaluation,
    /// Task for reviewing changes for production readiness
    release_readiness_review,
    /// Task for automated release testing
    release_testing,

    pub const json_field_names = .{
        .investigation = "INVESTIGATION",
        .evaluation = "EVALUATION",
        .release_readiness_review = "RELEASE_READINESS_REVIEW",
        .release_testing = "RELEASE_TESTING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .investigation => "INVESTIGATION",
            .evaluation => "EVALUATION",
            .release_readiness_review => "RELEASE_READINESS_REVIEW",
            .release_testing => "RELEASE_TESTING",
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
