const std = @import("std");

pub const ResourceType = enum {
    identity_source,
    policy_store,
    policy,
    policy_template,
    schema,
    policy_store_alias,

    pub const json_field_names = .{
        .identity_source = "IDENTITY_SOURCE",
        .policy_store = "POLICY_STORE",
        .policy = "POLICY",
        .policy_template = "POLICY_TEMPLATE",
        .schema = "SCHEMA",
        .policy_store_alias = "POLICY_STORE_ALIAS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .identity_source => "IDENTITY_SOURCE",
            .policy_store => "POLICY_STORE",
            .policy => "POLICY",
            .policy_template => "POLICY_TEMPLATE",
            .schema => "SCHEMA",
            .policy_store_alias => "POLICY_STORE_ALIAS",
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
