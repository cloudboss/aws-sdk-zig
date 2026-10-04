const std = @import("std");

pub const GroupKey = enum {
    scan_status_code,
    scan_status_reason,
    account_id,
    resource_type,
    ecr_repository_name,
    provider,
    provider_account_id,
    provider_region,
    provider_org_id,

    pub const json_field_names = .{
        .scan_status_code = "SCAN_STATUS_CODE",
        .scan_status_reason = "SCAN_STATUS_REASON",
        .account_id = "ACCOUNT_ID",
        .resource_type = "RESOURCE_TYPE",
        .ecr_repository_name = "ECR_REPOSITORY_NAME",
        .provider = "PROVIDER",
        .provider_account_id = "PROVIDER_ACCOUNT_ID",
        .provider_region = "PROVIDER_REGION",
        .provider_org_id = "PROVIDER_ORG_ID",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .scan_status_code => "SCAN_STATUS_CODE",
            .scan_status_reason => "SCAN_STATUS_REASON",
            .account_id => "ACCOUNT_ID",
            .resource_type => "RESOURCE_TYPE",
            .ecr_repository_name => "ECR_REPOSITORY_NAME",
            .provider => "PROVIDER",
            .provider_account_id => "PROVIDER_ACCOUNT_ID",
            .provider_region => "PROVIDER_REGION",
            .provider_org_id => "PROVIDER_ORG_ID",
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
