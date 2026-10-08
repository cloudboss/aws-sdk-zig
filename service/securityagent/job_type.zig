const std = @import("std");

/// The type of pentest job execution.
pub const JobType = enum {
    /// A full pentest job that executes all phases including scanning, managed
    /// execution, and guided exploration.
    full,
    /// A targeted revalidation job that retests specific findings to determine
    /// whether they are still exploitable.
    revalidation,
    /// A CI/CD pentest job that tests only the code changes in a single pipeline
    /// run, as determined by the scope changes supplied when the job is started.
    cicd,

    pub const json_field_names = .{
        .full = "FULL",
        .revalidation = "REVALIDATION",
        .cicd = "CICD",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .full => "FULL",
            .revalidation => "REVALIDATION",
            .cicd => "CICD",
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
