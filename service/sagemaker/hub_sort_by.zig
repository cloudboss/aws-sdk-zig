const std = @import("std");

pub const HubSortBy = enum {
    hub_name,
    creation_time,
    hub_status,
    account_id_owner,

    pub const json_field_names = .{
        .hub_name = "HubName",
        .creation_time = "CreationTime",
        .hub_status = "HubStatus",
        .account_id_owner = "AccountIdOwner",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .hub_name => "HubName",
            .creation_time => "CreationTime",
            .hub_status => "HubStatus",
            .account_id_owner => "AccountIdOwner",
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
