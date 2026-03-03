const std = @import("std");

pub const ExceptionResourceType = enum {
    user,
    group,
    namespace,
    account_settings,
    iampolicy_assignment,
    data_source,
    data_set,
    vpc_connection,
    ingestion,

    pub const json_field_names = .{
        .user = "USER",
        .group = "GROUP",
        .namespace = "NAMESPACE",
        .account_settings = "ACCOUNT_SETTINGS",
        .iampolicy_assignment = "IAMPOLICY_ASSIGNMENT",
        .data_source = "DATA_SOURCE",
        .data_set = "DATA_SET",
        .vpc_connection = "VPC_CONNECTION",
        .ingestion = "INGESTION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .user => "USER",
            .group => "GROUP",
            .namespace => "NAMESPACE",
            .account_settings => "ACCOUNT_SETTINGS",
            .iampolicy_assignment => "IAMPOLICY_ASSIGNMENT",
            .data_source => "DATA_SOURCE",
            .data_set => "DATA_SET",
            .vpc_connection => "VPC_CONNECTION",
            .ingestion => "INGESTION",
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
