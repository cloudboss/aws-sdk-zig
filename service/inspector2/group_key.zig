const std = @import("std");

pub const GroupKey = enum {
    scan_status_code,
    scan_status_reason,
    account_id,
    resource_type,
    ecr_repository_name,

    pub const json_field_names = .{
        .scan_status_code = "SCAN_STATUS_CODE",
        .scan_status_reason = "SCAN_STATUS_REASON",
        .account_id = "ACCOUNT_ID",
        .resource_type = "RESOURCE_TYPE",
        .ecr_repository_name = "ECR_REPOSITORY_NAME",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .scan_status_code => "SCAN_STATUS_CODE",
            .scan_status_reason => "SCAN_STATUS_REASON",
            .account_id => "ACCOUNT_ID",
            .resource_type => "RESOURCE_TYPE",
            .ecr_repository_name => "ECR_REPOSITORY_NAME",
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
