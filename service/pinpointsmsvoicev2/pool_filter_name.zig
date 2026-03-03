const std = @import("std");

pub const PoolFilterName = enum {
    status,
    message_type,
    two_way_enabled,
    self_managed_opt_outs_enabled,
    opt_out_list_name,
    shared_routes_enabled,
    deletion_protection_enabled,
    two_way_channel_arn,

    pub const json_field_names = .{
        .status = "status",
        .message_type = "message-type",
        .two_way_enabled = "two-way-enabled",
        .self_managed_opt_outs_enabled = "self-managed-opt-outs-enabled",
        .opt_out_list_name = "opt-out-list-name",
        .shared_routes_enabled = "shared-routes-enabled",
        .deletion_protection_enabled = "deletion-protection-enabled",
        .two_way_channel_arn = "two-way-channel-arn",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .status => "status",
            .message_type => "message-type",
            .two_way_enabled => "two-way-enabled",
            .self_managed_opt_outs_enabled => "self-managed-opt-outs-enabled",
            .opt_out_list_name => "opt-out-list-name",
            .shared_routes_enabled => "shared-routes-enabled",
            .deletion_protection_enabled => "deletion-protection-enabled",
            .two_way_channel_arn => "two-way-channel-arn",
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
