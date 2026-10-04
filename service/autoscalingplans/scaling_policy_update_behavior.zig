const std = @import("std");

pub const ScalingPolicyUpdateBehavior = enum {
    keep_external_policies,
    replace_external_policies,

    pub const json_field_names = .{
        .keep_external_policies = "KeepExternalPolicies",
        .replace_external_policies = "ReplaceExternalPolicies",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .keep_external_policies => "KeepExternalPolicies",
            .replace_external_policies => "ReplaceExternalPolicies",
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
