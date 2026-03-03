const std = @import("std");

pub const SortField = enum {
    aws_account_id,
    finding_type,
    severity,
    first_observed_at,
    last_observed_at,
    finding_status,
    resource_type,
    ecr_image_pushed_at,
    ecr_image_repository_name,
    ecr_image_registry,
    network_protocol,
    component_type,
    vulnerability_id,
    vulnerability_source,
    inspector_score,
    vendor_severity,
    epss_score,

    pub const json_field_names = .{
        .aws_account_id = "AWS_ACCOUNT_ID",
        .finding_type = "FINDING_TYPE",
        .severity = "SEVERITY",
        .first_observed_at = "FIRST_OBSERVED_AT",
        .last_observed_at = "LAST_OBSERVED_AT",
        .finding_status = "FINDING_STATUS",
        .resource_type = "RESOURCE_TYPE",
        .ecr_image_pushed_at = "ECR_IMAGE_PUSHED_AT",
        .ecr_image_repository_name = "ECR_IMAGE_REPOSITORY_NAME",
        .ecr_image_registry = "ECR_IMAGE_REGISTRY",
        .network_protocol = "NETWORK_PROTOCOL",
        .component_type = "COMPONENT_TYPE",
        .vulnerability_id = "VULNERABILITY_ID",
        .vulnerability_source = "VULNERABILITY_SOURCE",
        .inspector_score = "INSPECTOR_SCORE",
        .vendor_severity = "VENDOR_SEVERITY",
        .epss_score = "EPSS_SCORE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_account_id => "AWS_ACCOUNT_ID",
            .finding_type => "FINDING_TYPE",
            .severity => "SEVERITY",
            .first_observed_at => "FIRST_OBSERVED_AT",
            .last_observed_at => "LAST_OBSERVED_AT",
            .finding_status => "FINDING_STATUS",
            .resource_type => "RESOURCE_TYPE",
            .ecr_image_pushed_at => "ECR_IMAGE_PUSHED_AT",
            .ecr_image_repository_name => "ECR_IMAGE_REPOSITORY_NAME",
            .ecr_image_registry => "ECR_IMAGE_REGISTRY",
            .network_protocol => "NETWORK_PROTOCOL",
            .component_type => "COMPONENT_TYPE",
            .vulnerability_id => "VULNERABILITY_ID",
            .vulnerability_source => "VULNERABILITY_SOURCE",
            .inspector_score => "INSPECTOR_SCORE",
            .vendor_severity => "VENDOR_SEVERITY",
            .epss_score => "EPSS_SCORE",
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
