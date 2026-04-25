const std = @import("std");

pub const GroupByField = enum {
    activity_name,
    cloud_account_uid,
    cloud_provider,
    cloud_region,
    compliance_assessments_name,
    compliance_status,
    compliance_control,
    finding_info_title,
    finding_info_related_events_traits_category,
    finding_info_types,
    metadata_product_name,
    metadata_product_uid,
    resources_type,
    resources_uid,
    severity,
    status,
    vulnerabilities_fix_coverage,
    class_name,
    vulnerabilities_affected_packages_name,
    finding_info_analytic_name,
    compliance_standards,
    cloud_account_name,
    vendor_attributes_severity,
    metadata_product_vendor_name,

    pub const json_field_names = .{
        .activity_name = "activity_name",
        .cloud_account_uid = "cloud.account.uid",
        .cloud_provider = "cloud.provider",
        .cloud_region = "cloud.region",
        .compliance_assessments_name = "compliance.assessments.name",
        .compliance_status = "compliance.status",
        .compliance_control = "compliance.control",
        .finding_info_title = "finding_info.title",
        .finding_info_related_events_traits_category = "finding_info.related_events.traits.category",
        .finding_info_types = "finding_info.types",
        .metadata_product_name = "metadata.product.name",
        .metadata_product_uid = "metadata.product.uid",
        .resources_type = "resources.type",
        .resources_uid = "resources.uid",
        .severity = "severity",
        .status = "status",
        .vulnerabilities_fix_coverage = "vulnerabilities.fix_coverage",
        .class_name = "class_name",
        .vulnerabilities_affected_packages_name = "vulnerabilities.affected_packages.name",
        .finding_info_analytic_name = "finding_info.analytic.name",
        .compliance_standards = "compliance.standards",
        .cloud_account_name = "cloud.account.name",
        .vendor_attributes_severity = "vendor_attributes.severity",
        .metadata_product_vendor_name = "metadata.product.vendor_name",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .activity_name => "activity_name",
            .cloud_account_uid => "cloud.account.uid",
            .cloud_provider => "cloud.provider",
            .cloud_region => "cloud.region",
            .compliance_assessments_name => "compliance.assessments.name",
            .compliance_status => "compliance.status",
            .compliance_control => "compliance.control",
            .finding_info_title => "finding_info.title",
            .finding_info_related_events_traits_category => "finding_info.related_events.traits.category",
            .finding_info_types => "finding_info.types",
            .metadata_product_name => "metadata.product.name",
            .metadata_product_uid => "metadata.product.uid",
            .resources_type => "resources.type",
            .resources_uid => "resources.uid",
            .severity => "severity",
            .status => "status",
            .vulnerabilities_fix_coverage => "vulnerabilities.fix_coverage",
            .class_name => "class_name",
            .vulnerabilities_affected_packages_name => "vulnerabilities.affected_packages.name",
            .finding_info_analytic_name => "finding_info.analytic.name",
            .compliance_standards => "compliance.standards",
            .cloud_account_name => "cloud.account.name",
            .vendor_attributes_severity => "vendor_attributes.severity",
            .metadata_product_vendor_name => "metadata.product.vendor_name",
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
