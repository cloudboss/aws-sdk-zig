const std = @import("std");

pub const FindingsTrendsStringField = enum {
    account_id,
    region,
    finding_type,
    finding_status,
    cve_id,
    compliance_status,
    compliance_control,
    finding_class,
    provider_name,
    finding_activity_name,

    pub const json_field_names = .{
        .account_id = "account_id",
        .region = "region",
        .finding_type = "finding_types",
        .finding_status = "finding_status",
        .cve_id = "finding_cve_ids",
        .compliance_status = "finding_compliance_status",
        .compliance_control = "finding_control_id",
        .finding_class = "finding_class_name",
        .provider_name = "finding_provider",
        .finding_activity_name = "finding_activity_name",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .account_id => "account_id",
            .region => "region",
            .finding_type => "finding_types",
            .finding_status => "finding_status",
            .cve_id => "finding_cve_ids",
            .compliance_status => "finding_compliance_status",
            .compliance_control => "finding_control_id",
            .finding_class => "finding_class_name",
            .provider_name => "finding_provider",
            .finding_activity_name => "finding_activity_name",
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
