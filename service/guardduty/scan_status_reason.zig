const std = @import("std");

pub const ScanStatusReason = enum {
    access_denied,
    resource_not_found,
    snapshot_size_limit_exceeded,
    resource_unavailable,
    inconsistent_source,
    incremental_no_difference,
    no_ebs_volumes_found,
    unsupported_product_code_type,
    ami_snapshot_limit_exceeded,
    unrelated_resources,
    base_resource_not_scanned,
    base_created_after_target,
    unsupported_for_incremental,
    unsupported_ami,
    unsupported_snapshot,
    unsupported_composite_recovery_point,
    all_files_skipped_or_failed,

    pub const json_field_names = .{
        .access_denied = "ACCESS_DENIED",
        .resource_not_found = "RESOURCE_NOT_FOUND",
        .snapshot_size_limit_exceeded = "SNAPSHOT_SIZE_LIMIT_EXCEEDED",
        .resource_unavailable = "RESOURCE_UNAVAILABLE",
        .inconsistent_source = "INCONSISTENT_SOURCE",
        .incremental_no_difference = "INCREMENTAL_NO_DIFFERENCE",
        .no_ebs_volumes_found = "NO_EBS_VOLUMES_FOUND",
        .unsupported_product_code_type = "UNSUPPORTED_PRODUCT_CODE_TYPE",
        .ami_snapshot_limit_exceeded = "AMI_SNAPSHOT_LIMIT_EXCEEDED",
        .unrelated_resources = "UNRELATED_RESOURCES",
        .base_resource_not_scanned = "BASE_RESOURCE_NOT_SCANNED",
        .base_created_after_target = "BASE_CREATED_AFTER_TARGET",
        .unsupported_for_incremental = "UNSUPPORTED_FOR_INCREMENTAL",
        .unsupported_ami = "UNSUPPORTED_AMI",
        .unsupported_snapshot = "UNSUPPORTED_SNAPSHOT",
        .unsupported_composite_recovery_point = "UNSUPPORTED_COMPOSITE_RECOVERY_POINT",
        .all_files_skipped_or_failed = "ALL_FILES_SKIPPED_OR_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .access_denied => "ACCESS_DENIED",
            .resource_not_found => "RESOURCE_NOT_FOUND",
            .snapshot_size_limit_exceeded => "SNAPSHOT_SIZE_LIMIT_EXCEEDED",
            .resource_unavailable => "RESOURCE_UNAVAILABLE",
            .inconsistent_source => "INCONSISTENT_SOURCE",
            .incremental_no_difference => "INCREMENTAL_NO_DIFFERENCE",
            .no_ebs_volumes_found => "NO_EBS_VOLUMES_FOUND",
            .unsupported_product_code_type => "UNSUPPORTED_PRODUCT_CODE_TYPE",
            .ami_snapshot_limit_exceeded => "AMI_SNAPSHOT_LIMIT_EXCEEDED",
            .unrelated_resources => "UNRELATED_RESOURCES",
            .base_resource_not_scanned => "BASE_RESOURCE_NOT_SCANNED",
            .base_created_after_target => "BASE_CREATED_AFTER_TARGET",
            .unsupported_for_incremental => "UNSUPPORTED_FOR_INCREMENTAL",
            .unsupported_ami => "UNSUPPORTED_AMI",
            .unsupported_snapshot => "UNSUPPORTED_SNAPSHOT",
            .unsupported_composite_recovery_point => "UNSUPPORTED_COMPOSITE_RECOVERY_POINT",
            .all_files_skipped_or_failed => "ALL_FILES_SKIPPED_OR_FAILED",
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
