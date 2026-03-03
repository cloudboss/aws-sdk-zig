const std = @import("std");

pub const CriterionKey = enum {
    ec2_instance_arn,
    scan_id,
    account_id,
    guardduty_finding_id,
    scan_start_time,
    scan_status,
    scan_type,

    pub const json_field_names = .{
        .ec2_instance_arn = "EC2_INSTANCE_ARN",
        .scan_id = "SCAN_ID",
        .account_id = "ACCOUNT_ID",
        .guardduty_finding_id = "GUARDDUTY_FINDING_ID",
        .scan_start_time = "SCAN_START_TIME",
        .scan_status = "SCAN_STATUS",
        .scan_type = "SCAN_TYPE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ec2_instance_arn => "EC2_INSTANCE_ARN",
            .scan_id => "SCAN_ID",
            .account_id => "ACCOUNT_ID",
            .guardduty_finding_id => "GUARDDUTY_FINDING_ID",
            .scan_start_time => "SCAN_START_TIME",
            .scan_status => "SCAN_STATUS",
            .scan_type => "SCAN_TYPE",
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
