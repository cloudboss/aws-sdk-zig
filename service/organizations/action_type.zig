const std = @import("std");

pub const ActionType = enum {
    invite_account_to_organization,
    enable_all_features,
    approve_all_features,
    add_organizations_service_linked_role,
    transfer_responsibility,

    pub const json_field_names = .{
        .invite_account_to_organization = "INVITE",
        .enable_all_features = "ENABLE_ALL_FEATURES",
        .approve_all_features = "APPROVE_ALL_FEATURES",
        .add_organizations_service_linked_role = "ADD_ORGANIZATIONS_SERVICE_LINKED_ROLE",
        .transfer_responsibility = "TRANSFER_RESPONSIBILITY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invite_account_to_organization => "INVITE",
            .enable_all_features => "ENABLE_ALL_FEATURES",
            .approve_all_features => "APPROVE_ALL_FEATURES",
            .add_organizations_service_linked_role => "ADD_ORGANIZATIONS_SERVICE_LINKED_ROLE",
            .transfer_responsibility => "TRANSFER_RESPONSIBILITY",
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
