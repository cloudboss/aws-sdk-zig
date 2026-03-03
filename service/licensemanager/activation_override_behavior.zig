const std = @import("std");

pub const ActivationOverrideBehavior = enum {
    distributed_grants_only,
    all_grants_permitted_by_issuer,

    pub const json_field_names = .{
        .distributed_grants_only = "DISTRIBUTED_GRANTS_ONLY",
        .all_grants_permitted_by_issuer = "ALL_GRANTS_PERMITTED_BY_ISSUER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .distributed_grants_only => "DISTRIBUTED_GRANTS_ONLY",
            .all_grants_permitted_by_issuer => "ALL_GRANTS_PERMITTED_BY_ISSUER",
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
