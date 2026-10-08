const std = @import("std");

/// AWS DevOps Agent capability types representing the set of automated
/// capabilities that can be enabled per association.
pub const CapabilityType = enum {
    /// Release readiness review auto-trigger capability.
    release_readiness_review,
    /// Release readiness review automated testing capability.
    release_readiness_review_automated_testing,

    pub const json_field_names = .{
        .release_readiness_review = "RELEASE_READINESS_REVIEW",
        .release_readiness_review_automated_testing = "RELEASE_READINESS_REVIEW_AUTOMATED_TESTING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .release_readiness_review => "RELEASE_READINESS_REVIEW",
            .release_readiness_review_automated_testing => "RELEASE_READINESS_REVIEW_AUTOMATED_TESTING",
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
