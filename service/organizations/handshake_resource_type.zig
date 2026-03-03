const std = @import("std");

pub const HandshakeResourceType = enum {
    account,
    organization,
    organization_feature_set,
    email,
    master_email,
    master_name,
    notes,
    parent_handshake,
    responsibility_transfer,
    transfer_start_timestamp,
    transfer_type,
    management_account,
    management_email,
    management_name,

    pub const json_field_names = .{
        .account = "ACCOUNT",
        .organization = "ORGANIZATION",
        .organization_feature_set = "ORGANIZATION_FEATURE_SET",
        .email = "EMAIL",
        .master_email = "MASTER_EMAIL",
        .master_name = "MASTER_NAME",
        .notes = "NOTES",
        .parent_handshake = "PARENT_HANDSHAKE",
        .responsibility_transfer = "RESPONSIBILITY_TRANSFER",
        .transfer_start_timestamp = "TRANSFER_START_TIMESTAMP",
        .transfer_type = "TRANSFER_TYPE",
        .management_account = "MANAGEMENT_ACCOUNT",
        .management_email = "MANAGEMENT_EMAIL",
        .management_name = "MANAGEMENT_NAME",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .account => "ACCOUNT",
            .organization => "ORGANIZATION",
            .organization_feature_set => "ORGANIZATION_FEATURE_SET",
            .email => "EMAIL",
            .master_email => "MASTER_EMAIL",
            .master_name => "MASTER_NAME",
            .notes => "NOTES",
            .parent_handshake => "PARENT_HANDSHAKE",
            .responsibility_transfer => "RESPONSIBILITY_TRANSFER",
            .transfer_start_timestamp => "TRANSFER_START_TIMESTAMP",
            .transfer_type => "TRANSFER_TYPE",
            .management_account => "MANAGEMENT_ACCOUNT",
            .management_email => "MANAGEMENT_EMAIL",
            .management_name => "MANAGEMENT_NAME",
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
