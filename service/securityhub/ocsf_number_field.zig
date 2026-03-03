const std = @import("std");

pub const OcsfNumberField = enum {
    activity_id,
    compliance_status_id,
    confidence_score,
    severity_id,
    status_id,
    finding_info_related_events_count,
    evidences_api_response_code,
    evidences_dst_endpoint_autonomous_system_number,
    evidences_dst_endpoint_port,
    evidences_src_endpoint_autonomous_system_number,
    evidences_src_endpoint_port,
    resources_image_in_use_count,
    vulnerabilities_cve_cvss_base_score,
    vendor_attributes_severity_id,

    pub const json_field_names = .{
        .activity_id = "activity_id",
        .compliance_status_id = "compliance.status_id",
        .confidence_score = "confidence_score",
        .severity_id = "severity_id",
        .status_id = "status_id",
        .finding_info_related_events_count = "finding_info.related_events_count",
        .evidences_api_response_code = "evidences.api.response.code",
        .evidences_dst_endpoint_autonomous_system_number = "evidences.dst_endpoint.autonomous_system.number",
        .evidences_dst_endpoint_port = "evidences.dst_endpoint.port",
        .evidences_src_endpoint_autonomous_system_number = "evidences.src_endpoint.autonomous_system.number",
        .evidences_src_endpoint_port = "evidences.src_endpoint.port",
        .resources_image_in_use_count = "resources.image.in_use_count",
        .vulnerabilities_cve_cvss_base_score = "vulnerabilities.cve.cvss.base_score",
        .vendor_attributes_severity_id = "vendor_attributes.severity_id",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .activity_id => "activity_id",
            .compliance_status_id => "compliance.status_id",
            .confidence_score => "confidence_score",
            .severity_id => "severity_id",
            .status_id => "status_id",
            .finding_info_related_events_count => "finding_info.related_events_count",
            .evidences_api_response_code => "evidences.api.response.code",
            .evidences_dst_endpoint_autonomous_system_number => "evidences.dst_endpoint.autonomous_system.number",
            .evidences_dst_endpoint_port => "evidences.dst_endpoint.port",
            .evidences_src_endpoint_autonomous_system_number => "evidences.src_endpoint.autonomous_system.number",
            .evidences_src_endpoint_port => "evidences.src_endpoint.port",
            .resources_image_in_use_count => "resources.image.in_use_count",
            .vulnerabilities_cve_cvss_base_score => "vulnerabilities.cve.cvss.base_score",
            .vendor_attributes_severity_id => "vendor_attributes.severity_id",
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
