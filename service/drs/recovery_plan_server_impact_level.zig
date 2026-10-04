const std = @import("std");

/// The impact level of a server within a Recovery Plan step. `CRITICAL` means
/// the step fails if this server fails. `OPTIONAL` means the step continues
/// even if this server fails.
pub const RecoveryPlanServerImpactLevel = enum {
    critical,
    optional,

    pub const json_field_names = .{
        .critical = "CRITICAL",
        .optional = "OPTIONAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .critical => "CRITICAL",
            .optional => "OPTIONAL",
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
