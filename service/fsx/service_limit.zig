const std = @import("std");

/// The types of limits on your service utilization. Limits include file system
/// count,
/// total throughput capacity, total storage, and total user-initiated backups.
/// These limits
/// apply for a specific account in a specific Amazon Web Services Region. You
/// can increase some of them by
/// contacting Amazon Web Services Support.
pub const ServiceLimit = enum {
    file_system_count,
    total_throughput_capacity,
    total_storage,
    total_user_initiated_backups,
    total_user_tags,
    total_in_progress_copy_backups,
    storage_virtual_machines_per_file_system,
    volumes_per_file_system,
    total_ssd_iops,
    file_cache_count,

    pub const json_field_names = .{
        .file_system_count = "FILE_SYSTEM_COUNT",
        .total_throughput_capacity = "TOTAL_THROUGHPUT_CAPACITY",
        .total_storage = "TOTAL_STORAGE",
        .total_user_initiated_backups = "TOTAL_USER_INITIATED_BACKUPS",
        .total_user_tags = "TOTAL_USER_TAGS",
        .total_in_progress_copy_backups = "TOTAL_IN_PROGRESS_COPY_BACKUPS",
        .storage_virtual_machines_per_file_system = "STORAGE_VIRTUAL_MACHINES_PER_FILE_SYSTEM",
        .volumes_per_file_system = "VOLUMES_PER_FILE_SYSTEM",
        .total_ssd_iops = "TOTAL_SSD_IOPS",
        .file_cache_count = "FILE_CACHE_COUNT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .file_system_count => "FILE_SYSTEM_COUNT",
            .total_throughput_capacity => "TOTAL_THROUGHPUT_CAPACITY",
            .total_storage => "TOTAL_STORAGE",
            .total_user_initiated_backups => "TOTAL_USER_INITIATED_BACKUPS",
            .total_user_tags => "TOTAL_USER_TAGS",
            .total_in_progress_copy_backups => "TOTAL_IN_PROGRESS_COPY_BACKUPS",
            .storage_virtual_machines_per_file_system => "STORAGE_VIRTUAL_MACHINES_PER_FILE_SYSTEM",
            .volumes_per_file_system => "VOLUMES_PER_FILE_SYSTEM",
            .total_ssd_iops => "TOTAL_SSD_IOPS",
            .file_cache_count => "FILE_CACHE_COUNT",
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
