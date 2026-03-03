const std = @import("std");

pub const ResolutionStrategy = enum {
    optimistic_concurrency,
    lambda,
    automerge,
    none,

    pub const json_field_names = .{
        .optimistic_concurrency = "OPTIMISTIC_CONCURRENCY",
        .lambda = "LAMBDA",
        .automerge = "AUTOMERGE",
        .none = "NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .optimistic_concurrency => "OPTIMISTIC_CONCURRENCY",
            .lambda => "LAMBDA",
            .automerge => "AUTOMERGE",
            .none => "NONE",
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
