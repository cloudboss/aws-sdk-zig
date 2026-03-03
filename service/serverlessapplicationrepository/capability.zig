const std = @import("std");

/// Values that must be specified in order to deploy some applications.
pub const Capability = enum {
    capability_iam,
    capability_named_iam,
    capability_auto_expand,
    capability_resource_policy,

    pub const json_field_names = .{
        .capability_iam = "CAPABILITY_IAM",
        .capability_named_iam = "CAPABILITY_NAMED_IAM",
        .capability_auto_expand = "CAPABILITY_AUTO_EXPAND",
        .capability_resource_policy = "CAPABILITY_RESOURCE_POLICY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .capability_iam => "CAPABILITY_IAM",
            .capability_named_iam => "CAPABILITY_NAMED_IAM",
            .capability_auto_expand => "CAPABILITY_AUTO_EXPAND",
            .capability_resource_policy => "CAPABILITY_RESOURCE_POLICY",
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
