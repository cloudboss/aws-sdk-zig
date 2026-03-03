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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
