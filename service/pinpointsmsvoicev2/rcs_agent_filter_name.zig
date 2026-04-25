const std = @import("std");

/// The filter name for filtering RCS agents. The available filter names are:
///
/// * `deletion-protection-enabled`: Filter by deletion protection status.
/// * `opt-out-list-name`: Filter by the opt-out list name.
/// * `self-managed-opt-outs-enabled`: Filter by self-managed opt-outs status.
/// * `status`: Filter by RCS agent status.
/// * `two-way-channel-arn`: Filter by the two-way channel ARN.
/// * `two-way-enabled`: Filter by two-way enabled status.
pub const RcsAgentFilterName = enum {
    status,
    two_way_enabled,
    self_managed_opt_outs_enabled,
    opt_out_list_name,
    deletion_protection_enabled,
    two_way_channel_arn,

    pub const json_field_names = .{
        .status = "status",
        .two_way_enabled = "two-way-enabled",
        .self_managed_opt_outs_enabled = "self-managed-opt-outs-enabled",
        .opt_out_list_name = "opt-out-list-name",
        .deletion_protection_enabled = "deletion-protection-enabled",
        .two_way_channel_arn = "two-way-channel-arn",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .status => "status",
            .two_way_enabled => "two-way-enabled",
            .self_managed_opt_outs_enabled => "self-managed-opt-outs-enabled",
            .opt_out_list_name => "opt-out-list-name",
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
