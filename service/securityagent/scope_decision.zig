const std = @import("std");

/// The scoping decision for a CI/CD pentest job, indicating whether the
/// supplied code changes are tested.
pub const ScopeDecision = enum {
    /// The code changes are in scope and are tested by the pentest job.
    in_scope,
    /// The code changes are out of scope and are not tested. No pentest is run for
    /// the changes.
    scoped_out,
    /// The code changes could not be conclusively scoped because of a conflict in
    /// the scoping inputs.
    scope_conflict,

    pub const json_field_names = .{
        .in_scope = "IN_SCOPE",
        .scoped_out = "SCOPED_OUT",
        .scope_conflict = "SCOPE_CONFLICT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in_scope => "IN_SCOPE",
            .scoped_out => "SCOPED_OUT",
            .scope_conflict => "SCOPE_CONFLICT",
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
